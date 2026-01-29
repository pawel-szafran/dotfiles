function hx_tmux -d "Integrate Helix with tmux"
    function _hx_tmux_test_pane_id
        tmux list-panes -F '#{pane_id} #{pane_title}' | while read id title
            if test "$title" = test-iex
                echo $id
                return 0
            end
        end
        return 1
    end

    switch $argv[1]
        case test_iex
            if _hx_tmux_test_pane_id >/dev/null
                return 0
            end
            tmux split-window -h -d \
                "printf '\\033]2;test-iex\\033\\\\'; mise x -- just test-iex"

        case test
            set -l file $argv[2]
            set -l test_pane (_hx_tmux_test_pane_id)

            if test $status -eq 0
                tmux send-keys -t $test_pane (printf 'test "%s"' $file) Enter
            else
                tmux display-popup -E -w 80% -h 80% -- bash -c "mise x -- just test $file; echo; read -n 1 -s -r -p '[Press any key to close]'"
            end
    end
end
