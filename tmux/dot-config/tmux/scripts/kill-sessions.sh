#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/session.sh"

tmux list-sessions -F "#{session_name}" | fzf --multi --reverse --header "Kill sessions (Tab to multi-select)" --header-first | while read session; do
    kill_session_with_teardown "$session"
done
