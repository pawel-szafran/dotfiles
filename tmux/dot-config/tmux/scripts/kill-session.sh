#!/usr/bin/env bash
session=$(tmux display-message -p "#{session_name}")
session_path=$(tmux display-message -p "#{pane_current_path}")

cd "$session_path" 2>/dev/null || {
    tmux kill-session -t "$session"
    exit 0
}

# Run teardown commands if recipes exist
for recipe in dev-down test-down; do
    if just --summary 2>/dev/null | tr ' ' '\n' | grep -qxF "$recipe"; then
        echo "Running just $recipe..."
        just "$recipe" 2>&1 || true
    fi
done

tmux kill-session -t "$session"
