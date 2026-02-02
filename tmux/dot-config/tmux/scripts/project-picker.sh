#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/project.sh"

# Step 1: Detect default project name from current directory
parent_dir=$(dirname "$PWD")
parent_name=$(basename "$parent_dir")
if [[ "$parent_name" == *.worktrees ]]; then
    default_project="${parent_name%.worktrees}"
else
    default_project=$(basename "$PWD")
fi

# Step 2: Get project name from user (placeholder shows default, Enter uses it)
query=$(gum input --header "Open project" --placeholder "$default_project")
[[ -z "$query" ]] && query="$default_project"

# Step 3: Find project via zoxide (exclude .worktrees directories)
matches=$(zoxide query -l "$query" 2>/dev/null | rg -v '\.worktrees' || true)
[[ -z "$matches" ]] && {
    echo "No matches for '$query'"
    sleep 1
    exit 1
}

match_count=$(echo "$matches" | wc -l | tr -d ' ')
if [[ "$match_count" -eq 1 ]]; then
    project_dir="$matches"
else
    project_dir=$(echo "$matches" | fzf --height=100% --reverse --header "Select project" --header-first)
    [[ -z "$project_dir" ]] && exit 0
fi

# Step 4: Get worktree list from worktrunk
cd "$project_dir"
worktrees_json=$(wt list --format=json 2>/dev/null || echo "[]")
branches=$(echo "$worktrees_json" | jq -r '.[].branch // empty' | sort)

# Step 5: Select branch or type new name
result=$(echo "$branches" | fzf --height=100% --reverse --header "Select or create a worktree" --header-first --print-query || true)
query_line=$(echo "$result" | sed -n '1p')
selection_line=$(echo "$result" | sed -n '2p')
name="${selection_line:-$query_line}"
[[ -z "$name" ]] && exit 0

# Step 6: Switch to worktree (create if needed)
if echo "$branches" | rg -qxF "$name"; then
    # Branch has worktree, just switch
    :
elif git rev-parse --verify "refs/heads/$name" &>/dev/null; then
    # Branch exists but no worktree, create worktree
    wt switch --yes "$name"
else
    # New branch, create branch and worktree
    wt switch --yes --create "$name"
fi

# Step 7: Get the worktree path (wt switch doesn't change dir in scripts)
target_dir=$(wt list --format=json | jq -r --arg b "$name" '.[] | select(.branch == $b) | .path')
[[ -z "$target_dir" ]] && {
    echo "Failed to find worktree for '$name'"
    sleep 1
    exit 1
}
session_name=$(basename "$target_dir")

# Step 8: Create or attach to session
open_project_session "$session_name" "$target_dir"
