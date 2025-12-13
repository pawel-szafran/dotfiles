##
## Integrate Helix with Zellij
##

function hx_zellij
    function iex_test_pane_exists
        zellij action dump-layout | grep -q '"+iex" "-S" "mix"'
    end

    switch $argv[1]
        case test_iex
            if iex_test_pane_exists
                return 0
            end
            zellij run -f --width 80% --height 80% -x 10% -y 10% -n iex-test -c -- mise x -- env MIX_ENV=test LOG_LEVEL=debug iex -S mix

        case test
            set -l file $argv[2]

            if iex_test_pane_exists
                zellij action toggle-floating-panes
                zellij action write-chars (printf 'test "%s"\r' $file)
            else
                zellij run -f --width 80% --height 80% -x 10% -y 10% -- mise x -- mix test $file
            end
    end
end
