#!/bin/sh
xrandr --output $1 --primary --mode 1920x1080 --output eDP1 --off
xmodmap $HOME/.Xmodmap
i3-msg restart
