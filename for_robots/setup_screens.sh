#!/bin/sh
# Automatically pick the screen config on boot based on whether we're docked
if lspci | grep -q "VGA.*NVIDIA"; then
    bash ~/.screenlayout/Docked.sh
else
    bash ~/.screenlayout/Undocked.sh
fi
