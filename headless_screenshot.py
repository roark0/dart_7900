#!/usr/bin/env python3
"""Fast headless screenshot utility for frontend pages.

Features:
- Starts a temporary local static server rooted at `frontend/`
- Captures a Chromium headless screenshot at a fixed viewport size
- Optionally force-shows one or more modal sections by id (for preview)
- Cleans up temporary files and server process automatically
"""

from __future__ import annotations

import argparse
import contextlib
import os
import re
import shutil
import socket
import subprocess
import sys
import tempfile
import time
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Capture frontend page screenshots quickly.")
    parser.add_argument(
        "--page",
        required=True,
        help="Page path relative to frontend root, e.g. pages/test/parameter_edit.html",
    )
    parser.add_argument(
        "--output",
        help=(
            "Output image path. If omitted, output goes to <project>/tmp/. "
            "Relative paths are also resolved under <project>/tmp/."
        ),
    )
    parser.add_argument(
        "--size",
        default="800x480",
        help="Viewport size as WIDTHxHEIGHT (default: 800x480)",
    )
    parser.add_argument(
        "--frontend-root",
        default="frontend",
        help="Frontend root directory (default: frontend)",
    )
    parser.add_argument(
        "--port",
        type=int,
        default=8765,
        help="Preferred local HTTP port (default: 8765)",
    )
    parser.add_argument(
        "--show-modal",
        action="append",
        default=[],
        help='Force-show modal by id (repeatable), e.g. --show-modal control-modal',
    )
    parser.add_argument(
        "--chromium-bin",
        default="chromium",
        help="Chromium binary name/path (default: chromium)",
    )
    parser.add_argument(
        "--user-data-dir",
        default="/tmp/rt9700-chrome-test",
        help="Chromium user-data-dir (default: /tmp/rt9700-chrome-test)",
    )
    return parser.parse_args()


def wait_server_ready(host: str, port: int, server: subprocess.Popen, timeout_s: float = 5.0) -> None:
    end = time.time() + timeout_s
    last_error: Exception | None = None
    while time.time() < end:
        if server.poll() is not None:
            raise RuntimeError(f"HTTP server exited early with code {server.returncode}")
        try:
            with socket.create_connection((host, port), timeout=0.5):
                return
        except Exception as exc:  # noqa: BLE001
            last_error = exc
            time.sleep(0.1)
    raise RuntimeError(f"HTTP server not ready for {host}:{port}: {last_error}")


def is_port_available(host: str, port: int) -> bool:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        try:
            sock.bind((host, port))
            return True
        except OSError:
            return False


def find_available_port(host: str, preferred: int, max_tries: int = 30) -> int:
    if is_port_available(host, preferred):
        return preferred
    for port in range(preferred + 1, preferred + 1 + max_tries):
        if is_port_available(host, port):
            return port
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.bind((host, 0))
        return int(sock.getsockname()[1])


def force_show_modals(page_file: Path, modal_ids: list[str]) -> Path:
    src = page_file.read_text(encoding="utf-8")
    updated = src
    for modal_id in modal_ids:
        # Match any opening tag containing id="modal_id", then mutate class="..."
        tag_pattern = re.compile(
            rf"<(?P<tag>\w+)(?P<attrs>[^>]*\bid=\"{re.escape(modal_id)}\"[^>]*)>",
            re.IGNORECASE,
        )
        tag_match = tag_pattern.search(updated)
        if not tag_match:
            continue

        attrs = tag_match.group("attrs")
        class_pattern = re.compile(r'class="([^"]*)"', re.IGNORECASE)
        class_match = class_pattern.search(attrs)
        if not class_match:
            continue

        classes = class_match.group(1).split()
        classes = [c for c in classes if c != "hidden"]
        if "flex" not in classes:
            classes.append("flex")

        new_attrs = (
            attrs[: class_match.start(1)] + " ".join(classes) + attrs[class_match.end(1) :]
        )
        replacement = f"<{tag_match.group('tag')}{new_attrs}>"
        updated = updated[: tag_match.start()] + replacement + updated[tag_match.end() :]

    with tempfile.NamedTemporaryFile(
        mode="w",
        encoding="utf-8",
        suffix=page_file.suffix,
        prefix=f"{page_file.stem}.preview_",
        dir=page_file.parent,
        delete=False,
    ) as temp_file:
        temp_file.write(updated)
        return Path(temp_file.name)


def run() -> int:
    args = parse_args()
    project_root = Path(__file__).resolve().parents[1]
    frontend_root = Path(args.frontend_root).resolve()
    page_rel = Path(args.page)
    page_file = (frontend_root / page_rel).resolve()
    default_name = f"{page_file.stem}.png"
    if args.show_modal:
        default_name = f"{page_file.stem}_{'_'.join(args.show_modal)}.png"
    if args.output:
        out_arg = Path(args.output)
        output = out_arg if out_arg.is_absolute() else (project_root / "tmp" / out_arg)
    else:
        output = project_root / "tmp" / default_name
    output = output.resolve()

    if not frontend_root.is_dir():
        print(f"frontend root not found: {frontend_root}", file=sys.stderr)
        return 2
    if not page_file.is_file():
        print(f"page not found: {page_file}", file=sys.stderr)
        return 2
    if "x" not in args.size:
        print("size format must be WIDTHxHEIGHT, e.g. 800x480", file=sys.stderr)
        return 2

    width, height = args.size.split("x", 1)
    if not width.isdigit() or not height.isdigit():
        print("size format must be numeric WIDTHxHEIGHT", file=sys.stderr)
        return 2

    target_rel = page_rel
    temp_page: Path | None = None
    if args.show_modal:
        temp_page = force_show_modals(page_file, args.show_modal)
        target_rel = temp_page.relative_to(frontend_root)

    host = "127.0.0.1"
    server: subprocess.Popen | None = None
    temp_user_data_dir: str | None = None
    port = args.port
    last_start_error: Exception | None = None
    for _ in range(10):
        port = find_available_port(host, port)
        candidate = subprocess.Popen(  # noqa: S603
            ["python3", "-m", "http.server", str(port), "--bind", host],
            cwd=str(frontend_root),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        try:
            wait_server_ready(host, port, candidate)
            server = candidate
            break
        except Exception as exc:  # noqa: BLE001
            last_start_error = exc
            candidate.terminate()
            with contextlib.suppress(Exception):
                candidate.wait(timeout=1)
            port += 1

    if server is None:
        raise RuntimeError(f"failed to start HTTP server: {last_start_error}")

    base_url = f"http://{host}:{port}"
    target_url = f"{base_url}/{target_rel.as_posix()}"

    try:
        user_data_dir = args.user_data_dir
        if user_data_dir == "/tmp/rt9700-chrome-test":
            temp_user_data_dir = tempfile.mkdtemp(prefix="rt9700-chrome-test-")
            user_data_dir = temp_user_data_dir
        output.parent.mkdir(parents=True, exist_ok=True)
        cmd = [
            args.chromium_bin,
            "--headless",
            "--disable-gpu",
            "--disable-crash-reporter",
            "--disable-features=Crashpad",
            "--no-first-run",
            "--no-default-browser-check",
            f"--user-data-dir={user_data_dir}",
            f"--window-size={width},{height}",
            f"--screenshot={output}",
            target_url,
        ]
        proc = subprocess.run(cmd, check=False)  # noqa: S603
        if proc.returncode != 0:
            print(f"chromium exited with code {proc.returncode}", file=sys.stderr)
            return proc.returncode
        print(str(output))
        return 0
    finally:
        if server:
            server.terminate()
            with contextlib.suppress(Exception):
                server.wait(timeout=2)
        if temp_page and temp_page.exists():
            with contextlib.suppress(Exception):
                temp_page.unlink()
        if temp_user_data_dir:
            with contextlib.suppress(Exception):
                shutil.rmtree(temp_user_data_dir, ignore_errors=True)


if __name__ == "__main__":
    raise SystemExit(run())
