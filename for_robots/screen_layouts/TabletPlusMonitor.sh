#!/bin/sh

WacomPen='Wacom Pen and multitouch sensor Pen stylus'
WacomFinger='Wacom Pen and multitouch sensor Finger touch'
WacomEraser='Wacom Pen and multitouch sensor Pen eraser'
Tablet=eDP-1-1

outs=($(xrandr -q | grep -B 1 '3840x2160'))
nouts=${#outs[@]}

for out in "${outs[@]}"
do
    if [[ $out = DP* ]]
    then dp1=$out
    fi
done

echo $dp1 > $HOME/.leftmonitor
echo eDP-1-1 > $HOME/.rightmonitor

xrandr --output $dp1 --primary --mode 3840x2160 --pos 0x1400 --rotate normal \
       --output "$Tablet" --primary --auto --mode 2560x1440 --pos 3840x0 --rotate left \
       --output HDMI1 --off --output HDMI2 --off

xinput --map-to-output "$WacomPen" "$Tablet"
xinput --map-to-output "$WacomFinger" "$Tablet"
xinput --map-to-output "$WacomEraser" "$Tablet"

xsetwacom set "$WacomPen" Rotate none
xsetwacom set "$WacomFinger" Rotate none
xsetwacom set "$WacomEraser" Rotate none

xmodmap $HOME/.Xmodmap
i3-msg restart
