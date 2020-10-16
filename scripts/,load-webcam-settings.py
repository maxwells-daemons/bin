#!/bin/python3
import argparse
import subprocess
import os


def main(settings_file: str, device: str):
    with open(settings_file, "r") as f:
        setting_lines = f.readlines()

    for line in setting_lines:
        args = line.split()
        name = args[0]
        value = args[-1].split("=")[-1]

        subprocess.run(["v4l2-ctl", "-d", device, f"--set-ctrl={name}={value}"])


def cli():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", default=os.path.expanduser("~/.dotfiles/dotfiles/webcam-settings.txt"))
    parser.add_argument("-d", default="/dev/video0")
    args = parser.parse_args()
    main(args.f, args.d)


if __name__ == "__main__":
    cli()
