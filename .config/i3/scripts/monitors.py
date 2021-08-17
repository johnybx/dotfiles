#!/usr/bin/env python3
import argparse
import json
import os
import subprocess

DEFAULT_POS = "--left-of eDP-1"


def main():
    parser = argparse.ArgumentParser()
    default_path = os.path.join(
        os.path.dirname(os.path.realpath(__file__)), "monitor.conf"
    )
    parser.add_argument(
        "-c",
        "--config",
        help=f"Config file (default={default_path})",
        default=default_path,
    )
    args = parser.parse_args()
    if os.path.isfile(args.config):
        with open(args.config, "r") as f:
            config = f.read()

        config = json.loads(config)
    else:
        config = {}

    monitors = subprocess.run(
        'xrandr | grep "connected" | awk \'{print $1" "$2}\'',
        shell=True,
        stdout=subprocess.PIPE,
    )
    monitors = monitors.stdout.decode().split("\n")
    xrandr_cmd = "xrandr "
    for monitor in monitors:
        if not monitor:
            continue
        m, status = monitor.split(" ")
        if m in config["ignore"]:
            continue
        if status == "connected":
            xrandr_cmd += f"--output {m} {config.get(m,DEFAULT_POS)} --auto "
        else:
            xrandr_cmd += f"--output {m} --off "
    subprocess.run(xrandr_cmd, shell=True)


if __name__ == "__main__":
    main()
