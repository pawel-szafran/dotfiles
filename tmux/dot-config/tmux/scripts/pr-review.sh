#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/project.sh"

# Step 1: Get PR URL (pre-fill from clipboard)
clipboard=$(pbpaste 2>/dev/null || echo "")
url=$(gum input --header "Review PR" --placeholder "$clipboard")
[[ -z "$url" ]] && url="$clipboard"
[[ -z "$url" ]] && exit 0

# Step 2: Validate and parse PR URL
[[ "$url" =~ github\.com/.+/.+/pull/[0-9]+ ]] || bail "Invalid PR URL"

repo=$(echo "$url" | sed -E 's|.*/([^/]+)/pull/[0-9]+.*|\1|')
pr_number=$(echo "$url" | sed -E 's|.*/pull/([0-9]+).*|\1|')

[[ -z "$repo" || -z "$pr_number" ]] && bail "Invalid PR URL"

# Step 3: Resolve branch name via gh
branch=$(gh pr view "$url" --json headRefName --jq '.headRefName') || bail "Failed to fetch PR info"

# Step 4: Find project directory via zoxide
matches=$(zoxide query -l "$repo" 2>/dev/null | rg -v '\.worktrees' || true)
[[ -z "$matches" ]] && bail "No project found for '$repo'"

match_count=$(echo "$matches" | wc -l | tr -d ' ')
if [[ "$match_count" -eq 1 ]]; then
    project_dir="$matches"
else
    project_dir=$(echo "$matches" | fzf --height=100% --reverse --header "Select project" --header-first)
    [[ -z "$project_dir" ]] && exit 0
fi

# Step 5: Create worktree via wt
cd "$project_dir"
wt switch "pr:$pr_number" --yes --no-cd

# Step 6: Get worktree path and create session
target_dir=$(wt list --format=json | jq -r --arg b "$branch" '.[] | select(.branch == $b) | .path')
[[ -z "$target_dir" ]] && bail "Failed to find worktree for '$branch'"
session_name=$(basename "$target_dir")

# Step 7: Create or attach to session
open_project_session "$session_name" "$target_dir"
