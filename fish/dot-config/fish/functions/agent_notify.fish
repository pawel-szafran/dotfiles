function agent_notify --description "Send notification from AI agent"
    set -l agent $argv[1]
    set -l message $argv[2]
    set -l project (path basename (pwd))

    # Write state keyed by pane PID (stable across pane moves)
    set -l state_dir ~/.local/state/agents
    mkdir -p $state_dir
    set -l tmux_target $TMUX_PANE
    set -l pane_pid (tmux display-message -t "$tmux_target" -p "#{pane_pid}" 2>/dev/null)
    if test -n "$pane_pid"
        echo "$agent:$message" >"$state_dir/$pane_pid"
    end

    if test "$message" != Working
        terminal-notifier \
            -title "🤖 $project [$agent]" \
            -message "$message" \
            -group "$agent-$project"
    end
end
