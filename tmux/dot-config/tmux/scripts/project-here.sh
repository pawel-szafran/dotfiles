#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/project.sh"

project_dir=$(tmux display-message -p "#{pane_current_path}")
session_name=$(basename "$project_dir")

open_project_session "$session_name" "$project_dir"
