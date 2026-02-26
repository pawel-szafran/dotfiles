function hx_tmux -d "Integrate Helix with tmux"
    set -l hx_pid (command ps -o ppid= -p %self | string trim)

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

            echo $file > /tmp/hx_last_test.$hx_pid

            set -l test_pane (_hx_tmux_test_pane_id)

            if test $status -eq 0
                tmux send-keys -t $test_pane (printf 'test "%s"' $file) Enter
            else
                tmux display-popup -E -w 80% -h 80% -- bash -c "mise x -- just test $file; echo; read -n 1 -s -r -p '[Press any key to close]'"
            end

        case test_last
            set -l marker /tmp/hx_last_test.$hx_pid

            if not test -f $marker
                tmux display-message "No last test to rerun"
                return 1
            end

            hx_tmux test (cat $marker)
    end
end
