function agent_notify --description "Send notification from AI agent"
    set -l agent $argv[1]
    set -l message $argv[2]
    set -l project (path basename (pwd))

    terminal-notifier \
        -title "🤖 $project [$agent]" \
        -message "$message" \
        -group "$agent-$project"
end
