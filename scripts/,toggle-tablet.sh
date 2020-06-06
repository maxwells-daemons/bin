#!/bin/sh
#
# toggle_tablet.sh
#
# Toggles rotation and reloads i3. Should also start / stop a
# tablet-specific polybar.
#
# See: https://gist.github.com/mildmojo/48e9025070a2ba40795c
# and https://askubuntu.com/questions/147080/shell-script-to-toggle-between-two-commands

TOGGLE=$HOME/.tabletmode


if [ ! -e $TOGGLE ]; then  # Deactivate tablet mode
    touch $TOGGLE
    bash $HOME/bin/for_robots/rotate_desktop.sh normal
    # polybar-msg cmd hide
    i3-msg restart
    feh --bg-scale $HOME/media/img/wallpapers/ssss-ocean.jpg
    kill $(ps aux | grep '[p]olybar*' | awk '{print $2}')
    nohup polybar --config=$XDG_CONFIG_HOME/polybar/config main &> /dev/null &
else
    rm $TOGGLE  # Activate tablet mode
    bash $HOME/bin/for_robots/rotate_desktop.sh left
    # polybar-msg cmd show
    # polybar-msg action menu-open-0
    i3-msg restart
    feh --bg-scale  $HOME/media/img/wallpapers/ssss-bridge-thin.jpg
    kill $(ps aux | grep '[p]olybar*' | awk '{print $2}')
    nohup polybar --config=$XDG_CONFIG_HOME/polybar/config short &> /dev/null &
fi
