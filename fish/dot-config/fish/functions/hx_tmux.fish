function hx_tmux -d "Integrate Helix with tmux"
    set -l hx_pid (command ps -o ppid= -p %self | string trim)

    function _hx_tmux_test_popup
        tmux kill-session -t hx-test 2>/dev/null
        tmux new-session -d -s hx-test \
            "bash -c 'mise x -- just test $argv; echo; printf \"\\033[90m[Press any key to close]\\033[0m\"; read -n 1 -s -r'"
        tmux set-option -t hx-test detach-on-destroy on
        tmux set-option -t hx-test status off
        tmux display-popup -E -w 80% -h 80% -- tmux attach-session -t hx-test
    end

    switch $argv[1]
        case test
            set -l file $argv[2]

            echo $file >/tmp/hx_last_test.$hx_pid

            _hx_tmux_test_popup $file

        case test_all
            echo -n >/tmp/hx_last_test.$hx_pid
            _hx_tmux_test_popup

        case test_last
            set -l marker /tmp/hx_last_test.$hx_pid

            if not test -f $marker
                hx_tmux test_all
                return
            end

            set -l last (string trim < $marker)
            if test -z "$last"
                hx_tmux test_all
            else
                hx_tmux test $last
            end
    end
end
