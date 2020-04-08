#!/bin/sh
# Automatically pick the screen config on boot based on whether we're docked
if lspci | grep -q "VGA.*NVIDIA"; then
    bash ./screen_layouts/Docked.sh
else
    bash ./screen_layouts/Undocked.sh
fi
