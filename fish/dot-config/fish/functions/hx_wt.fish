##
## Integrate Helix with WezTerm
##

function hx_wt
    set -f project (path basename (pwd))

    function split_pane
        set -f direction $argv[1]
        set -g split_pane_id (wezterm cli get-pane-direction $direction)

        if test -z "$split_pane_id"
            switch $direction
                case up
                    set -f split_direction_opt --top
                case down
                    set -f split_direction_opt --bottom
                case left
                    set -f split_direction_opt --left
                case right
                    set -f split_direction_opt --right
            end
            set -g split_pane_id (wezterm cli split-pane $split_direction_opt -- $argv[3..-1])
        end

        wezterm cli activate-pane-direction --pane-id $split_pane_id $direction

        if test "$argv[2]" = zoom
            wezterm cli zoom-pane --pane-id $split_pane_id
        end
    end

    function send_to_split_pane
        wezterm cli send-text --pane-id $split_pane_id --no-paste $argv[1]\n
    end

    function match_split_pane_title
        set -f split_pane_title (wezterm cli list --format json | jq ".[] | select(.pane_id == $split_pane_id) | .title")
        string match -rq $argv[1] $split_pane_title
    end

    switch $argv[1]
        case term
            split_pane down zoom

        case test
            set -f file (string replace "$PWD/" '' $argv[2])
            split_pane down zoom

            if match_split_pane_title 'MIX_ENV=test'
                set -f cmd "test \"$file\""
            else
                set -f cmd "mix test $file"
            end

            send_to_split_pane $cmd

        case f
            split_pane right zoom yazi

        case F
            split_pane right zoom yazi $argv[2]

        case lg
            split_pane left zoom lazygit
    end

    functions -e tu_log
end
