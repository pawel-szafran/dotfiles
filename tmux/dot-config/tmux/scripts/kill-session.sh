#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/session.sh"

session=$(tmux display-message -p "#{session_name}")
kill_session_with_teardown "$session"
