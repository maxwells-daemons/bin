#!/bin/sh
# Link appropriate configs for xorg, systemd, etc
if lspci | grep -q "VGA.*NVIDIA"; then
    ln -s ${HOME}/bin/for_robots/egpu/egpu.conf /etc/X11/xorg.conf.d/50-egpu.conf
    ${HOME}/bin/scripts/,stay_open.sh
    rm /etc/X11/xorg.conf.d/50-no-egpu.conf
else
    ln -s ${HOME}/bin/for_robots/egpu/no-egpu.conf /etc/X11/xorg.conf.d/50-no-egpu.conf
    rm /etc/X11/xorg.conf.d/50-egpu.conf
fi
