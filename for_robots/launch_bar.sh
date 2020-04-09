#!/bin/sh

CONFIG_LOC=$XDG_CONFIG_HOME/polybar/config
N_DISPLAYS=$(xrandr --query | grep " connected" | wc -l)

# End existing polybar session
# See: https://stackoverflow.com/questions/3510673/
#      find-and-kill-a-process-in-one-line-using-bash-and-regex
kill $(ps aux | grep '[p]olybar*' | awk '{print $2}') 2> /dev/null

if [[ $N_DISPLAYS -gt 2 ]]; then
    # Three displays -> two external monitors
    feh --bg-scale $HOME/media/img/wallpapers/ssss-main.jpg \
        $HOME/media/img/wallpapers/ssss-bridge-thin.jpg

    nohup polybar --config=$CONFIG_LOC horizmonitor &> /dev/null &
    nohup polybar --config=$CONFIG_LOC vertmonitor &> /dev/null &
elif [[ $N_DISPLAYS -gt 1 ]]; then
    # Two displays -> one external monitor, plus laptop
    feh --bg-scale $HOME/media/img/wallpapers/ssss-main.jpg \
        $HOME/media/img/wallpapers/ssss-ocean.jpg

    nohup polybar --config=$CONFIG_LOC horizmonitor &> /dev/null &
    nohup polybar --config=$CONFIG_LOC main &> /dev/null &
else
    # One display -> just laptop screen
    feh --bg-scale $HOME/media/img/wallpapers/ssss-ocean-darkened.jpg
    nohup polybar --config=$CONFIG_LOC main &> /dev/null &
fi

compton --config $HOME/.config/compton.conf -b
