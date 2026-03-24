#!/usr/bin/env python3
"""Headless screenshot utility for static pages and Flutter desktop views."""

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
    parser = argparse.ArgumentParser(
        description="Capture screenshots for static pages or Flutter desktop views."
    )
    parser.add_argument(
        "--mode",
        choices=("static", "flutter-linux"),
        default="static",
        help=(
            "Capture mode. 'static' keeps the original HTML screenshot flow, "
            "'flutter-linux' captures the Flutter app via Xvfb."
        ),
    )
    parser.add_argument(
        "--output",
        help=(
            "Output image path. If omitted, output goes to <project>/tmp/. "
            "Relative paths are resolved under <project>/tmp/."
        ),
    )
    parser.add_argument(
        "--size",
        default="800x600",
        help="Viewport size as WIDTHxHEIGHT (default: 800x600)",
    )
    parser.add_argument(
        "--delay-ms",
        type=int,
        default=2500,
        help="Delay before capture in milliseconds (default: 2500)",
    )
    parser.add_argument(
        "--project-root",
        default=None,
        help="Project root. Defaults to the directory containing this script.",
    )

    static_group = parser.add_argument_group("static mode")
    static_group.add_argument(
        "--page",
        help="Page path relative to frontend root, e.g. pages/test/parameter_edit.html",
    )
    static_group.add_argument(
        "--frontend-root",
        default="frontend",
        help="Frontend root directory (default: frontend)",
    )
    static_group.add_argument(
        "--port",
        type=int,
        default=8765,
        help="Preferred local HTTP port (default: 8765)",
    )
    static_group.add_argument(
        "--show-modal",
        action="append",
        default=[],
        help="Force-show modal by id (repeatable), e.g. --show-modal control-modal",
    )
    static_group.add_argument(
        "--chromium-bin",
        default="chromium",
        help="Chromium binary name/path (default: chromium)",
    )
    static_group.add_argument(
        "--user-data-dir",
        default="/tmp/rt9700-chrome-test",
        help="Chromium user-data-dir (default: /tmp/rt9700-chrome-test)",
    )

    flutter_group = parser.add_argument_group("flutter-linux mode")
    flutter_group.add_argument(
        "--flutter-build-mode",
        choices=("debug", "release"),
        default="debug",
        help="Flutter Linux build mode (default: debug)",
    )
    flutter_group.add_argument(
        "--module",
        choices=(
            "analysis",
            "listReview",
            "ljQc",
            "maintenance",
            "addDiluent",
            "print",
        ),
        default="ljQc",
        help="Initial Flutter top module (default: ljQc)",
    )
    flutter_group.add_argument(
        "--lj-side",
        type=int,
        default=0,
        help="Initial L-J QC side menu index (default: 0)",
    )
    flutter_group.add_argument(
        "--screen-color-depth",
        type=int,
        default=24,
        help="Xvfb color depth (default: 24)",
    )
    flutter_group.add_argument(
        "--keep-raw",
        action="store_true",
        help="Keep the uncropped raw desktop capture next to the final output.",
    )
    flutter_group.add_argument(
        "--trim",
        action="store_true",
        help="Trim the desktop capture to the non-background bounds.",
    )
    flutter_group.add_argument(
        "--rebuild",
        action="store_true",
        help="Force a fresh Flutter Linux build before capture.",
    )

    return parser.parse_args()


def parse_size(size: str) -> tuple[int, int]:
    if "x" not in size:
        raise ValueError("size format must be WIDTHxHEIGHT, e.g. 800x600")
    width, height = size.split("x", 1)
    if not width.isdigit() or not height.isdigit():
        raise ValueError("size format must be numeric WIDTHxHEIGHT")
    return int(width), int(height)


def resolve_project_root(args: argparse.Namespace) -> Path:
    if args.project_root:
        return Path(args.project_root).resolve()
    return Path(__file__).resolve().parent


def resolve_output(project_root: Path, args: argparse.Namespace, default_name: str) -> Path:
    if args.output:
        out_arg = Path(args.output)
        output = out_arg if out_arg.is_absolute() else (project_root / "tmp" / out_arg)
    else:
        output = project_root / "tmp" / default_name
    output.parent.mkdir(parents=True, exist_ok=True)
    return output.resolve()


def wait_server_ready(
    host: str,
    port: int,
    server: subprocess.Popen,
    timeout_s: float = 5.0,
) -> None:
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
        classes = [class_name for class_name in classes if class_name != "hidden"]
        if "flex" not in classes:
            classes.append("flex")

        new_attrs = attrs[: class_match.start(1)] + " ".join(classes) + attrs[class_match.end(1) :]
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


def run_static_mode(args: argparse.Namespace, project_root: Path) -> int:
    if not args.page:
        print("--page is required in static mode", file=sys.stderr)
        return 2

    frontend_root = (project_root / args.frontend_root).resolve()
    page_rel = Path(args.page)
    page_file = (frontend_root / page_rel).resolve()
    default_name = f"{page_file.stem}.png"
    if args.show_modal:
        default_name = f"{page_file.stem}_{'_'.join(args.show_modal)}.png"
    output = resolve_output(project_root, args, default_name)

    if not frontend_root.is_dir():
        print(f"frontend root not found: {frontend_root}", file=sys.stderr)
        return 2
    if not page_file.is_file():
        print(f"page not found: {page_file}", file=sys.stderr)
        return 2

    width, height = parse_size(args.size)

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
        candidate = subprocess.Popen(
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

    target_url = f"http://{host}:{port}/{target_rel.as_posix()}"

    try:
        user_data_dir = args.user_data_dir
        if user_data_dir == "/tmp/rt9700-chrome-test":
            temp_user_data_dir = tempfile.mkdtemp(prefix="rt9700-chrome-test-")
            user_data_dir = temp_user_data_dir
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
        proc = subprocess.run(cmd, check=False)
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


def flutter_bundle_path(project_root: Path, build_mode: str) -> Path:
    app_name = project_root.name
    arch = "x64"
    return project_root / "build" / "linux" / arch / build_mode / "bundle" / app_name


def flutter_build_stamp_path(project_root: Path, build_mode: str) -> Path:
    return project_root / ".dart_tool" / f"headless_screenshot_linux_{build_mode}.stamp"


def latest_mtime(path: Path) -> float:
    if not path.exists():
        return 0.0
    if path.is_file():
        return path.stat().st_mtime

    latest = path.stat().st_mtime
    for child in path.rglob("*"):
        if child.is_file():
            latest = max(latest, child.stat().st_mtime)
    return latest


def needs_flutter_build(
    project_root: Path,
    build_mode: str,
    binary: Path,
    rebuild: bool,
) -> bool:
    if rebuild or not binary.is_file():
        return True

    stamp_path = flutter_build_stamp_path(project_root, build_mode)
    if not stamp_path.is_file():
        return True

    stamp_mtime = stamp_path.stat().st_mtime
    watched_paths = (
        project_root / "lib",
        project_root / "linux",
        project_root / "pubspec.yaml",
        project_root / "pubspec.lock",
    )
    return any(latest_mtime(path) > stamp_mtime for path in watched_paths)


def run_checked(
    cmd: list[str],
    cwd: Path | None = None,
    env: dict[str, str] | None = None,
) -> None:
    proc = subprocess.run(cmd, cwd=str(cwd) if cwd else None, env=env, check=False)
    if proc.returncode != 0:
        raise RuntimeError(f"command failed ({proc.returncode}): {' '.join(cmd)}")


def run_flutter_mode(args: argparse.Namespace, project_root: Path) -> int:
    width, height = parse_size(args.size)
    side_name = (
        ["settings", "analyse", "graph", "list"][max(0, min(args.lj_side, 3))]
        if args.module == "ljQc"
        else args.module
    )
    default_name = f"{args.module}_{side_name}.png"
    output = resolve_output(project_root, args, default_name)
    binary = flutter_bundle_path(project_root, args.flutter_build_mode)
    stamp_path = flutter_build_stamp_path(project_root, args.flutter_build_mode)

    if needs_flutter_build(project_root, args.flutter_build_mode, binary, args.rebuild):
        build_cmd = [
            "flutter",
            "build",
            "linux",
            f"--{args.flutter_build_mode}",
        ]
        run_checked(build_cmd, cwd=project_root)
        stamp_path.parent.mkdir(parents=True, exist_ok=True)
        stamp_path.touch()

    if not binary.is_file():
        print(f"flutter binary not found: {binary}", file=sys.stderr)
        return 2

    raw_output = output.with_name(f"{output.stem}.raw{output.suffix}")
    display = ":99"
    xvfb_cmd = [
        "Xvfb",
        display,
        "-screen",
        "0",
        f"{width}x{height}x{args.screen_color_depth}",
        "-ac",
    ]
    xvfb = subprocess.Popen(xvfb_cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    app: subprocess.Popen | None = None
    env = os.environ.copy()
    env["DISPLAY"] = display
    env["START_MODULE"] = args.module
    env["START_LJ_SIDE"] = str(args.lj_side)
    env["START_WINDOW_WIDTH"] = str(width)
    env["START_WINDOW_HEIGHT"] = str(height)

    try:
        time.sleep(0.5)
        if xvfb.poll() is not None:
            raise RuntimeError("Xvfb failed to start")
        app = subprocess.Popen(
            [str(binary)],
            env=env,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        time.sleep(max(args.delay_ms, 500) / 1000)
        run_checked(["import", "-display", display, "-window", "root", str(raw_output)])
        if args.trim:
            run_checked(["convert", str(raw_output), "-trim", "+repage", str(output)])
            if not args.keep_raw and raw_output.exists():
                raw_output.unlink()
        elif args.keep_raw:
            shutil.copy2(raw_output, output)
        else:
            shutil.move(raw_output, output)
        print(str(output))
        return 0
    finally:
        if app and app.poll() is None:
            app.terminate()
            with contextlib.suppress(Exception):
                app.wait(timeout=2)
        if xvfb.poll() is None:
            xvfb.terminate()
            with contextlib.suppress(Exception):
                xvfb.wait(timeout=2)
        if args.keep_raw and raw_output.exists():
            print(str(raw_output), file=sys.stderr)


def run() -> int:
    args = parse_args()
    project_root = resolve_project_root(args)
    try:
        if args.mode == "flutter-linux":
            return run_flutter_mode(args, project_root)
        return run_static_mode(args, project_root)
    except ValueError as exc:
        print(str(exc), file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(run())
