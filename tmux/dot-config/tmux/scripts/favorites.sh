#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/project.sh"

# Favorites list
selected=$(printf "notes\ndotfiles" | fzf --height=100% --reverse --header "Open favorite" --header-first)
[[ -z "$selected" ]] && exit 0

case "$selected" in
    notes)
        target_dir=$(zoxide query notes 2>/dev/null)
        [[ -z "$target_dir" ]] && {
            echo "notes not found in zoxide"
            sleep 1
            exit 1
        }
        session_name="notes"

        if tmux has-session -t="$session_name" 2>/dev/null; then
            action=$(gum choose --header="Session '$session_name' exists" "Attach" "Recreate")
            case "$action" in
                Attach)
                    tmux switch-client -t "$session_name"
                    ;;
                Recreate)
                    tmux kill-session -t "$session_name"
                    tmux new-session -d -s "$session_name" -n notes -c "$target_dir"
                    tmux send-keys -t "$session_name:notes" "hx ." Enter
                    tmux switch-client -t "$session_name"
                    ;;
            esac
        else
            tmux new-session -d -s "$session_name" -n notes -c "$target_dir"
            tmux send-keys -t "$session_name:notes" "hx ." Enter
            tmux switch-client -t "$session_name"
        fi
        ;;
    dotfiles)
        target_dir=$(zoxide query dotfiles 2>/dev/null)
        [[ -z "$target_dir" ]] && {
            echo "dotfiles not found in zoxide"
            sleep 1
            exit 1
        }
        session_name="dotfiles"

        open_project_session "$session_name" "$target_dir"
        ;;
esac
