#!/usr/bin/env bash
current=$(tmux display-message -p "#{window_index}")
tmux list-windows -F "#I: #W" | rg -v "^${current}:" | fzf --reverse --header "Switch window" --header-first | cut -d: -f1 | xargs -I{} tmux select-window -t :{}
