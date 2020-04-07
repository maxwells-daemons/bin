#!/bin/bash
#
# rotate_desktop.sh
# See: https://gist.github.com/mildmojo/48e9025070a2ba40795c
#
# Rotates modern Linux desktop screen and input devices to match. Handy for
# convertible notebooks. Call this script from panel launchers, keyboard
# shortcuts, or touch gesture bindings (xSwipe, touchegg, etc.).
#
# Using transformation matrix bits taken from:
#   https://wiki.ubuntu.com/X/InputCoordinateTransformation
#

# display from xrandr
Display='eDP1'

# Configure these to match your hardware (names taken from `xinput` output).
TOUCHPAD='SynPS/2 Synaptics TouchPad'
WacomPen='Wacom Pen and multitouch sensor Pen stylus'
WacomFinger='Wacom Pen and multitouch sensor Finger touch'
WacomEraser='Wacom Pen and multitouch sensor Pen eraser'

if [ -z "$1" ]; then
  echo "Missing orientation."
  echo "Usage: $0 [normal|inverted|left|right]"
  echo
  exit 1
fi

  xrandr --output $Display --rotate $1

  TRANSFORM='Coordinate Transformation Matrix'

  case "$1" in
    normal)
      [ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      xsetwacom set "$WacomPen" Rotate none
      xsetwacom set "$WacomFinger" Rotate none
      xsetwacom set "$WacomEraser" Rotate none
      ;;
    inverted)
      [ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      xsetwacom set "$WacomPen" Rotate half
      xsetwacom set "$WacomFinger" Rotate half
      xsetwacom set "$WacomEraser" Rotate half
      ;;
    left)
      [ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      xsetwacom set "$WacomPen" Rotate ccw
      xsetwacom set "$WacomFinger" Rotate ccw
      xsetwacom set "$WacomEraser" Rotate ccw
      ;;
    right)
      [ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      xsetwacom set "$WacomPen" Rotate cw
      xsetwacom set "$WacomFinger" Rotate cw
      xsetwacom set "$WacomEraser" Rotate cw
      ;;
  esac

## For Xubuntu, grep primary does not give anything
#XDISPLAY=`xrandr --current | grep primary | sed -e 's/ .*//g'`
# So, changing it to look for the word '\ connected' (to avoid 'disconnected'
# to avoid multile connected displays and choose the first one (-m1)
