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


# TODO: fix polybar config
if [ ! -e $TOGGLE ]; then  # Deactivate tablet mode
    touch $TOGGLE
    bash $HOME/bin/for_robots/rotate_desktop.sh normal
    # polybar-msg cmd hide
    i3-msg restart
    feh --bg-scale /home/whillikers/media/img/wallpapers/ssss-ocean.jpg
    kill $(ps aux | grep '[p]olybar*' | awk '{print $2}')
    nohup polybar --config=/home/whillikers/.config/polybar/nordic nordic_main &> /dev/null &
else
    rm $TOGGLE  # Activate tablet mode
    bash $HOME/bin/for_robots/rotate_desktop.sh left
    # polybar-msg cmd show
    # polybar-msg action menu-open-0
    i3-msg restart
    feh --bg-scale  /home/whillikers/media/img/wallpapers/ssss-bridge-thin.jpg
    kill $(ps aux | grep '[p]olybar*' | awk '{print $2}')
    nohup polybar --config=/home/whillikers/.config/polybar/nordic nordic_short &> /dev/null &
fi
