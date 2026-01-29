#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"

selected=$(gum choose --header="Delete:" "Windows" "Sessions" "Worktrees")
[[ -z "$selected" ]] && exit 0

case "$selected" in
    Windows)
        exec "$SCRIPT_DIR/delete-windows.sh"
        ;;
    Sessions)
        exec "$SCRIPT_DIR/delete-sessions.sh"
        ;;
    Worktrees)
        exec "$SCRIPT_DIR/worktree-remove.sh"
        ;;
esac
