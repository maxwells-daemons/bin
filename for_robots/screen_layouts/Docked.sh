#!/bin/sh

outs=($(xrandr -q | grep -B 1 '3840x2160'))
nouts=${#outs[@]}

shopt -s extglob
for out in "${outs[@]}"
do
    if [[ $out = DP-0* ]]
    then dp2=$out
    elif [[ $out = DP-* ]]
    then dp1=$out
    fi
done

echo $dp1 > $HOME/.leftmonitor
echo $dp2 > $HOME/.rightmonitor

xrandr --output $dp1 --primary --mode 3840x2160 --pos 0x1400 --rotate normal \
       --output $dp2 --mode 3840x2160 --pos 3840x0 --rotate right \
       --output eDP-1-1 --off --output HDMI1 --off --output HDMI2 --off

xmodmap $HOME/.Xmodmap
i3-msg restart
