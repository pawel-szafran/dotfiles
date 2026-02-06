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

handle_current_session() {
    local current_session="$1"

    if gum confirm "Kill '$current_session' session?" --default=false; then
        echo "$current_session"
    fi
}

open_project_session() {
    local session_name="$1"
    local target_dir="$2"

    local current_session=$(tmux display-message -p "#{session_name}")
    local session_to_kill=""

    # Don't ask about current session if we're opening the same one
    if [[ "$current_session" != "$session_name" ]]; then
        session_to_kill=$(handle_current_session "$current_session")
    fi

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

    # Kill old session after switching
    if [[ -n "$session_to_kill" ]]; then
        tmux kill-session -t="$session_to_kill" 2>/dev/null || true
    fi

    return 0
}
