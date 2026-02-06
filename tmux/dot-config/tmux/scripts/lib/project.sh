#!/usr/bin/env bash
# Shared functions for project scripts

get_current_project_name() {
    local parent_dir=$(dirname "$PWD")
    local parent_name=$(basename "$parent_dir")
    if [[ "$parent_name" == *.worktrees ]]; then
        echo "${parent_name%.worktrees}"
    else
        echo "$(basename "$PWD")"
    fi
}

create_project_session() {
    local session_name="$1"
    local target_dir="$2"

    tmux new-session -d -s "$session_name" -n git -c "$target_dir"
    tmux send-keys -t "$session_name:git" "lazygit" Enter
    tmux new-window -t "$session_name" -n code -c "$target_dir"
    tmux send-keys -t "$session_name:code" "hx ." Enter
    tmux select-window -t "$session_name:git"
    tmux switch-client -t "$session_name"
}

open_project_session() {
    local session_name="$1"
    local target_dir="$2"

    if tmux has-session -t="$session_name" 2>/dev/null; then
        action=$(gum choose --header="Session '$session_name' exists" "Attach" "Recreate")
        case "$action" in
            Attach)
                tmux switch-client -t "$session_name"
                ;;
            Recreate)
                tmux kill-session -t "$session_name"
                create_project_session "$session_name" "$target_dir"
                ;;
        esac
    else
        create_project_session "$session_name" "$target_dir"
    fi

    return 0
}
