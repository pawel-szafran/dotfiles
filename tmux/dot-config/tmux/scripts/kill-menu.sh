#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"

selected=$(gum choose --header="Kill:" "Windows" "Sessions" "Worktrees")
[[ -z "$selected" ]] && exit 0

case "$selected" in
    Windows)
        exec "$SCRIPT_DIR/kill-windows.sh"
        ;;
    Sessions)
        exec "$SCRIPT_DIR/kill-sessions.sh"
        ;;
    Worktrees)
        exec "$SCRIPT_DIR/kill-worktrees.sh"
        ;;
esac
