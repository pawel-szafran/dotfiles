#!/usr/bin/env bash
# Toggle between even-horizontal and even-vertical for 2-pane windows
pane_tops=$(tmux list-panes -F "#{pane_top}" | sort -u | wc -l)
if [ "$pane_tops" -eq 1 ]; then
  tmux select-layout even-vertical
else
  tmux select-layout even-horizontal
fi
