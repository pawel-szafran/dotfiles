#!/usr/bin/env bash
# Shared functions for session management

kill_session_with_teardown() {
    local session="$1"
    local session_path

    session_path=$(tmux display-message -t "$session" -p "#{pane_current_path}" 2>/dev/null)

    if [[ -n "$session_path" ]] && cd "$session_path" 2>/dev/null; then
        for recipe in dev-down test-down; do
            if just --summary 2>/dev/null | tr ' ' '\n' | grep -qxF "$recipe"; then
                echo "[$session] Running just $recipe..."
                just "$recipe" 2>&1 || true
            fi
        done
    fi

    tmux kill-session -t "$session"
}
