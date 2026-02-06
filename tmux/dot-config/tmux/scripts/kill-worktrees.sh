#!/usr/bin/env bash

# Get worktrees from worktrunk
worktrees_json=$(wt list --format=json 2>/dev/null || echo "[]")

# Get current branch to exclude it
current_branch=$(git branch --show-current 2>/dev/null || echo "")

# Extract branch names, excluding current branch
branches=$(echo "$worktrees_json" | jq -r '.[].branch // empty' | sort)
if [[ -n "$current_branch" ]]; then
    branches=$(echo "$branches" | rg -vxF "$current_branch" || true)
fi

[[ -z "$branches" ]] && {
    echo "No worktrees to remove"
    sleep 1
    exit 0
}

# Multi-select worktrees to remove
selected=$(echo "$branches" | fzf --height=100% --reverse --multi --header "Kill worktrees (Tab to multi-select)" --header-first)
[[ -z "$selected" ]] && exit 0

branch_list=$(echo "$selected" | tr '\n' ' ')

# Remove worktrees, retrying with force flags if needed
flags=()
while true; do
    output_file=$(mktemp)
    wt remove --yes --foreground "${flags[@]}" $branch_list 2>&1 | tee "$output_file" || true
    output=$(<"$output_file")
    rm -f "$output_file"

    if echo "$output" | grep -q "run wt remove"; then
        echo
        if gum confirm "Retry with force flags?"; then
            flags=()
            selected_flags=$(printf "Force remove worktree (untracked files)\nForce delete branch (unmerged)" |
                gum choose --no-limit --header "Select flags")
            [[ "$selected_flags" == *"worktree"* ]] && flags+=("-f")
            [[ "$selected_flags" == *"branch"* ]] && flags+=("-D")
            echo
            continue
        fi
    fi
    break
done

echo
read -n 1 -s -r -p "[Press any key to close]"
