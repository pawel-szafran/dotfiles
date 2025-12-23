function p -d "Set up project tab"
    if set -q argv[1]
        z $argv[1]
    end

    set -f project (path basename (pwd))

    if zellij list-sessions -ns | string match -q $project
        zellij delete-session -f $project
    end

    zellij action rename-session $project
    set -gx ZELLIJ_SESSION_NAME $project

    zellij action rename-tab code

    zellij action new-tab --name git
    zellij action rename-pane lazygit
    zellij action write-chars (printf ' wait; exec lazygit\r')
    zellij action move-tab left

    zellij action go-to-tab-name code
    zellij action rename-pane hx
    exec hx .
end
