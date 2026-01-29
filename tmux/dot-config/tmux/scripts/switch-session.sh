#!/usr/bin/env bash
current=$(tmux display-message -p "#{session_name}")
tmux list-sessions -F "#{session_name}" | rg -v "^${current}$" | fzf --reverse --header "Switch session" --header-first | xargs tmux switch-client -t
