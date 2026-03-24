#!/usr/bin/env python3
"""Convert a PNG image into an approximate SVG using color quantization.

This is aimed at UI screenshots and similar flat-color images. It reduces the
image to a limited palette, extracts filled regions per color, and writes them
as SVG paths.
"""

from __future__ import annotations

import argparse
import html
from dataclasses import dataclass
from pathlib import Path

import cv2
import numpy as np
from PIL import Image


@dataclass(frozen=True)
class SvgPath:
    color: str
    d: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert a PNG image to an approximate SVG."
    )
    parser.add_argument("input", type=Path, help="Input PNG path")
    parser.add_argument("output", type=Path, help="Output SVG path")
    parser.add_argument(
        "--colors",
        type=int,
        default=16,
        help="Number of colors after quantization (default: 16)",
    )
    parser.add_argument(
        "--min-area",
        type=float,
        default=12.0,
        help="Ignore contours smaller than this area (default: 12)",
    )
    parser.add_argument(
        "--epsilon",
        type=float,
        default=1.2,
        help="Contour simplification in pixels (default: 1.2)",
    )
    parser.add_argument(
        "--background",
        default=None,
        help="Force background fill color, e.g. '#ffffff'",
    )
    return parser.parse_args()


def quantize_image(image: Image.Image, colors: int) -> tuple[np.ndarray, list[tuple[int, int, int]]]:
    rgb = image.convert("RGB")
    quantized = rgb.quantize(colors=colors, method=Image.Quantize.MEDIANCUT)
    indexed = np.array(quantized, dtype=np.uint8)

    raw_palette = quantized.getpalette() or []
    palette: list[tuple[int, int, int]] = []
    for idx in range(colors):
        base = idx * 3
        if base + 2 >= len(raw_palette):
            palette.append((0, 0, 0))
            continue
        palette.append(
            (raw_palette[base], raw_palette[base + 1], raw_palette[base + 2])
        )
    return indexed, palette


def rgb_to_hex(rgb: tuple[int, int, int]) -> str:
    return "#{:02x}{:02x}{:02x}".format(*rgb)


def contour_to_path(contour: np.ndarray) -> str:
    points = contour.reshape(-1, 2)
    if len(points) == 0:
        return ""
    commands = [f"M {int(points[0][0])} {int(points[0][1])}"]
    commands.extend(f"L {int(x)} {int(y)}" for x, y in points[1:])
    commands.append("Z")
    return " ".join(commands)


def build_svg_paths(
    indexed: np.ndarray,
    palette: list[tuple[int, int, int]],
    min_area: float,
    epsilon: float,
) -> list[SvgPath]:
    paths: list[SvgPath] = []
    used_indices = sorted(int(v) for v in np.unique(indexed))

    for palette_index in used_indices:
        mask = np.where(indexed == palette_index, 255, 0).astype(np.uint8)
        contours, _hierarchy = cv2.findContours(
            mask, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE
        )
        color = rgb_to_hex(palette[palette_index])

        for contour in contours:
            area = cv2.contourArea(contour)
            if area < min_area:
                continue
            approx = cv2.approxPolyDP(contour, epsilon, True)
            path_data = contour_to_path(approx)
            if path_data:
                paths.append(SvgPath(color=color, d=path_data))

    return sorted(paths, key=lambda item: len(item.d))


def write_svg(
    output: Path,
    width: int,
    height: int,
    paths: list[SvgPath],
    background: str | None,
    source_name: str,
) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        (
            f'<svg xmlns="http://www.w3.org/2000/svg" '
            f'width="{width}" height="{height}" viewBox="0 0 {width} {height}" '
            f'shape-rendering="geometricPrecision">'
        ),
        f"  <title>{html.escape(source_name)}</title>",
    ]
    if background:
        lines.append(
            f'  <rect x="0" y="0" width="{width}" height="{height}" fill="{background}"/>'
        )
    for path in paths:
        lines.append(f'  <path d="{path.d}" fill="{path.color}" stroke="none"/>')
    lines.append("</svg>")
    output.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    args = parse_args()
    image = Image.open(args.input)
    indexed, palette = quantize_image(image, args.colors)
    paths = build_svg_paths(indexed, palette, args.min_area, args.epsilon)
    width, height = image.size
    write_svg(
        output=args.output,
        width=width,
        height=height,
        paths=paths,
        background=args.background,
        source_name=args.input.name,
    )
    print(f"Wrote {args.output} with {len(paths)} paths")


if __name__ == "__main__":
    main()
