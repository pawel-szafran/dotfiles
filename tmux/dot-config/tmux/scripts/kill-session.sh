#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

session=$(tmux display-message -p "#{session_name}")
session_path=$(tmux display-message -p "#{pane_current_path}")

gum confirm --default "Kill session '$session'?" || exit 0

# Detect if session is in a worktree (resolve root even if cd'd into a subdir)
delete_worktree=false
worktree_root=$(cd "$session_path" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null) || true
if [[ -n "$worktree_root" ]]; then
    parent_dir=$(dirname "$worktree_root")
    parent_name=$(basename "$parent_dir")
    if [[ "$parent_name" == *.worktrees ]]; then
        repo_name="${parent_name%.worktrees}"
        repo_dir="$(dirname "$parent_dir")/$repo_name"
        branch=$(wt list --format=json -C "$repo_dir" 2>/dev/null |
            jq -r --arg p "$worktree_root" '.[] | select(.path == $p) | .branch // empty')
        if [[ -n "$branch" ]] && gum confirm --default=false "Also delete worktree '$branch'?"; then
            delete_worktree=true
        fi
    fi
fi

# Run teardown recipes (needs dir to still exist)
if [[ -n "$session_path" ]] && cd "$session_path" 2>/dev/null; then
    for recipe in dev-down test-down; do
        if just --summary 2>/dev/null | tr ' ' '\n' | grep -qxF "$recipe"; then
            echo "[$session] Running just $recipe..."
            just "$recipe" 2>&1 || true
        fi
    done
fi

# Remove worktree (interactive, needs terminal alive)
if [[ "$delete_worktree" == true ]]; then
    flags=()
    while true; do
        output_file=$(mktemp)
        wt remove --yes --foreground -C "$repo_dir" "${flags[@]}" "$branch" 2>&1 | tee "$output_file" || true
        output=$(<"$output_file")
        rm -f "$output_file"

        if echo "$output" | grep -q "run wt remove"; then
            echo
            if gum confirm --default=false "Force delete worktree?"; then
                flags=(-f -D)
                echo
                continue
            fi
        fi
        break
    done
fi

# Kill session last (closes the popup)
tmux kill-session -t "$session"
