#!/bin/sh

if [[ -z "$@" ]]; then
    tmux ls -F "#{session_name}"
else
    if tmux ls -F "#{session_name}" | grep -q "^$@$"; then
        coproc kitty -e /bin/bash -c "tmux attach -t $@; bash" > /dev/null
    else
        coproc kitty -e /bin/bash -c "tmux new-session -s $@; bash" > /dev/null
    fi
fi
