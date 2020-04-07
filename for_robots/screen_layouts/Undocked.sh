#!/bin/sh

WacomPen='Wacom Pen and multitouch sensor Pen stylus'
WacomFinger='Wacom Pen and multitouch sensor Finger touch'
WacomEraser='Wacom Pen and multitouch sensor Pen eraser'
Tablet=eDP-1-1

xsetwacom set "$WacomPen" Rotate none
xsetwacom set "$WacomFinger" Rotate none
xsetwacom set "$WacomEraser" Rotate none
xinput --map-to-output "$WacomPen" "$Tablet"
xinput --map-to-output "$WacomFinger" "$Tablet"
xinput --map-to-output "$WacomEraser" "$Tablet"

xrandr --output VIRTUAL1 --off --output eDP-1-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP1 --off --output DP1-1 --off --output DP1-2 --off --output DP1-3 --off --output DP2 --off --output DP2-1 --off --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off

i3-msg restart
feh --bg-scale ${HOME}/media/img/wallpapers/ssss-ocean-darkened.jpg
compton --config ${HOME}/.config/compton.conf -b

# See: https://stackoverflow.com/questions/3510673/
#      find-and-kill-a-process-in-one-line-using-bash-and-regex
kill $(ps aux | grep '[p]olybar*' | awk '{print $2}')
echo eDP-1-1 > ${HOME}/.leftmonitor
nohup polybar --config=${HOME}/.config/polybar/gigavolt gigavolt_main &> /dev/null &

# TODO: fix config locations
