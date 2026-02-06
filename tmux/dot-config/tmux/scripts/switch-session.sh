#!/usr/bin/env bash
current=$(tmux display-message -p "#{session_name}")
query="${1:-}"
tmux list-sessions -F "#{session_name}" | rg -v "^${current}$" | fzf --reverse --header "Switch session" --header-first --query "$query" | xargs tmux switch-client -t
