#!/usr/bin/env bash
set -e

# Get worktrees from worktrunk
worktrees_json=$(wt list --format=json 2>/dev/null || echo "[]")

# Get current branch to exclude it
current_branch=$(git branch --show-current 2>/dev/null || echo "")

# Extract branch names, excluding current branch
branches=$(echo "$worktrees_json" | jq -r '.[].branch // empty' | sort)
if [[ -n "$current_branch" ]]; then
    branches=$(echo "$branches" | rg -vxF "$current_branch" || true)
fi

[[ -z "$branches" ]] && { echo "No worktrees to remove"; sleep 1; exit 0; }

# Multi-select worktrees to remove
selected=$(echo "$branches" | fzf --height=100% --reverse --multi --header "Remove worktrees (Tab to multi-select)" --header-first)
[[ -z "$selected" ]] && exit 0

# Convert newlines to space-separated list and remove
branch_list=$(echo "$selected" | tr '\n' ' ')
wt remove $branch_list
