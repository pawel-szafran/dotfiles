#!/usr/bin/env bash
set -e

AGENT_PATTERNS="claude|droid|claudesp"
STATE_DIR="$HOME/.local/state/agents"
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
BLUE='\033[34m'
RESET='\033[0m'

# Prune state files for dead PIDs
if [[ -d "$STATE_DIR" ]]; then
    for f in "$STATE_DIR"/*; do
        [[ -f "$f" ]] || continue
        pid=$(basename "$f")
        kill -0 "$pid" 2>/dev/null || rm -f "$f"
    done
fi

lines=""

while IFS='|' read -r pane_pid session window wname pane cmd path; do
    state_file="$STATE_DIR/$pane_pid"
    if [[ -f "$state_file" ]]; then
        state=$(cut -d: -f2- <"$state_file")
    else
        state="Started"
    fi

    case "$state" in
        *"Needs input"*) colored_state="${RED}${state}${RESET}" ;;
        *"Finished"*) colored_state="${GREEN}${state}${RESET}" ;;
        *"Started"*) colored_state="${BLUE}${state}${RESET}" ;;
        *) colored_state="${YELLOW}${state}${RESET}" ;;
    esac

    # Truncate long session names
    if (( ${#session} > 39 )); then
        display_session="${session:0:36}..."
    else
        display_session="$session"
    fi

    target="${session}:${window}.${pane}"
    line=$(printf "%-39s %-14s %-10s %b\t%s" "$display_session" "$wname" "$cmd" "$colored_state" "$target")
    lines+="${line}"$'\n'
done < <(tmux list-panes -a -F "#{pane_pid}|#{session_name}|#{window_index}|#{window_name}|#{pane_index}|#{pane_current_command}|#{pane_current_path}" |
    awk -F'|' -v pat="^(${AGENT_PATTERNS})$" '$6 ~ pat')

if [[ -z "$lines" ]]; then
    echo "No agents running"
    sleep 1
    exit 0
fi

selected=$(echo -n "$lines" | sort |
    fzf --ansi --reverse --with-nth=1 --delimiter='\t' \
        --header "Session                                 Window          Agent      State" \
        --header-first --no-multi)

[[ -z "$selected" ]] && exit 0

target=$(echo "$selected" | awk -F'\t' '{print $NF}')
tmux switch-client -t "$target"
