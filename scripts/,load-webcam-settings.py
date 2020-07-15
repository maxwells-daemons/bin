#!/bin/python3
import click
import subprocess


@click.command()
@click.option(
    "-f",
    "--settings-file",
    type=click.Path(exists=True, dir_okay=False),
    default="/home/whillikers/dotfiles/dotfiles/webcam-settings.txt",
)
@click.option(
    "-d",
    "--device",
    type=click.Path(exists=True, dir_okay=False),
    default="/dev/video0",
)
def main(settings_file: str, device: str):
    with open(settings_file, "r") as f:
        setting_lines = f.readlines()

    for line in setting_lines:
        args = line.split()
        name = args[0]
        value = args[-1].split("=")[-1]

        subprocess.run(["v4l2-ctl", "-d", device, f"--set-ctrl={name}={value}"])


if __name__ == "__main__":
    main()
