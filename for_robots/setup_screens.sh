#!/bin/sh
BASE_DIR=$(dirname $(realpath $0))

# Automatically pick the screen config on boot based on whether we're docked
if lspci | grep -q "VGA.*NVIDIA"; then
    bash $BASE_DIR/screen_layouts/Docked.sh
else
    bash $BASE_DIR/screen_layouts/Undocked.sh
fi
