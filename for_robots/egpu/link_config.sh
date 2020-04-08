#!/bin/sh
# Link appropriate configs for xorg, systemd, etc
rm -f /etc/X11/xorg.conf.d/50-no-egpu.conf etc/X11/xorg.conf.d/50-egpu.conf
if lspci | grep -q "VGA.*NVIDIA"; then
    ln -sf /home/whillikers/bin/for_robots/egpu/egpu.conf /etc/X11/xorg.conf.d/50-egpu.conf
    /home/whillikers/bin/scripts/,stay_open.sh
else
    ln -sf /home/whillikers/bin/for_robots/egpu/no-egpu.conf /etc/X11/xorg.conf.d/50-no-egpu.conf
fi
