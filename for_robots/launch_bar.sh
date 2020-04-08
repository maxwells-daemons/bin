#!/bin/sh

# TODO: fix config locations and names
CONFIG_LOC=$HOME/.config/polybar/gigavolt
N_DISPLAYS=$(xrandr --query | grep " connected" | wc -l)

# End existing polybar session
# See: https://stackoverflow.com/questions/3510673/
#      find-and-kill-a-process-in-one-line-using-bash-and-regex
kill $(ps aux | grep '[p]olybar*' | awk '{print $2}') 2> /dev/null

if [[ $N_DISPLAYS -gt 2 ]]; then
    # Three displays -> two external monitors
    feh --bg-scale ${HOME}/media/img/wallpapers/ssss-main.jpg \
        ${HOME}/media/img/wallpapers/ssss-bridge-thin.jpg

    nohup polybar --config=$CONFIG_LOC gigavolt_horizmonitor &> /dev/null &
    nohup polybar --config=$CONFIG_LOC gigavolt_vertmonitor &> /dev/null &
elif [[ $N_DISPLAYS -gt 1 ]]; then
    # Two displays -> one external monitor, plus laptop
    feh --bg-scale $HOME/media/img/wallpapers/ssss-main.jpg \
        $HOME/media/img/wallpapers/ssss-ocean.jpg

    nohup polybar --config=$CONFIG_LOC gigavolt_horizmonitor &> /dev/null &
    nohup polybar --config=$CONFIG_LOC gigavolt_main &> /dev/null &
else
    # One display -> just laptop screen
    feh --bg-scale ${HOME}/media/img/wallpapers/ssss-ocean-darkened.jpg
    nohup polybar --config=$CONFIG_LOC gigavolt_main &> /dev/null &
fi

compton --config ${HOME}/.config/compton.conf -b
