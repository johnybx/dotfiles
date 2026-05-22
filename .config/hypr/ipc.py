#!/usr/bin/env python3

import signal
import os
import socket
import re
import subprocess

MONITORS = ["Dell Inc. DELL P3421W GXHBJ53"]


def on_monitor_added(match: re.Match[str]):
    if match["monitor_desc"] in MONITORS:
        for workspace in [2, 3]:
            _ = subprocess.call(
                [
                    "hyprctl",
                    "dispatch",
                    f'hl.dsp.workspace.move({{workspace="{workspace}", monitor="{match["monitor_id"]}"}})',
                ]
            )


HANDLERS = [
    (
        re.compile(
            r"^monitoraddedv2>>(?P<monitor_id>.*?),(?P<monitor_name>.*?),(?P<monitor_desc>.*)$"
        ),
        on_monitor_added,
    )
]


def handle(line: str):
    for pattern, handler in HANDLERS:
        if match := pattern.match(line):
            handler(match)


def main():
    runtime_dir = os.environ["XDG_RUNTIME_DIR"]
    instance_signature = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]

    socket_path = f"{runtime_dir}/hypr/{instance_signature}/.socket2.sock"

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(socket_path)

    def stop(*_):
        try:
            sock.shutdown(socket.SHUT_RDWR)
        except OSError:
            pass  # already closed/disconnected

        try:
            sock.close()
        except OSError:
            pass

    # Register signal handlers
    _ = signal.signal(signal.SIGINT, stop)  # Ctrl+C
    _ = signal.signal(signal.SIGTERM, stop)  # kill/systemd stop

    # Read line-by-line like `while read -r line`
    with sock.makefile("r") as stream:
        for line in stream:
            handle(line.strip())


if __name__ == "__main__":
    main()
