#!/bin/sh
($1) &&
    (notify-send $'Command finished:' "$1") ||
    (notify-send $'Command failed:' "$1")
