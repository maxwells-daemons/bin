#!/bin/sh
# Jump to the "a" mark, paste some text, and jump back

i3-msg "mark --add λ"
i3-msg '[con_mark="a"] focus'
sleep 0.025
LINES="$(pasteclip)"
while IFS= read -r line;
do
    xdotool type --clearmodifiers --delay 2 "$line"
    xdotool key KP_Enter
done <<< $LINES
i3-msg '[con_mark="λ"] focus'
unmark λ
