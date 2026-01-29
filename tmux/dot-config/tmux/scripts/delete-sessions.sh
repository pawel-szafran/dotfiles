#!/usr/bin/env bash
tmux list-sessions -F "#{session_name}" | fzf --multi --reverse --header "Delete sessions (Tab to multi-select)" --header-first | while read session; do
  tmux kill-session -t "$session"
done
