#!/usr/bin/env bash
tmux list-windows -F "#I: #W" | fzf --multi --reverse --header "Kill windows (Tab to multi-select)" --header-first | cut -d: -f1 | sort -rn | while read idx; do
    tmux kill-window -t :"$idx"
done
