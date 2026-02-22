#!/usr/bin/env bash
cur=$(tmux display-message -p "#S")
tmux list-sessions -F "#S" |
    rg -x '[0-9]+' |
    while read -r s; do
        [ "$s" != "$cur" ] && tmux kill-session -t "=$s" 2>/dev/null
    done
exit 0
