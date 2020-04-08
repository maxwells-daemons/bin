#!/bin/sh

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
       --output eDP-1-1 --off --output HDMI1 --off --output HDMI2 --off

xmodmap $HOME/.Xmodmap
i3-msg restart
