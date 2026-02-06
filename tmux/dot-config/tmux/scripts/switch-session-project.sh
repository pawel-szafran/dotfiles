#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/project.sh"

project=$(get_current_project_name)
exec ~/.config/tmux/scripts/switch-session.sh "$project"
