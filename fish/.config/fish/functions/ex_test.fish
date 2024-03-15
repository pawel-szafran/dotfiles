##
## Elixir: run test
##

function ex_test
    set -f project (path basename (pwd))

    set -f file (string replace "$PWD/" '' $argv[1])

    if test "$TEST_IN_IEX" = true
        set -f cmd "test \"$file\"\n"
    else
        set -f cmd "mix test $file\n"
    end

    kitten @ focus-window --match "title:^$project.test\$" --no-response
    kitten @ action clear_terminal to_cursor active
    kitten @ send-text --match "title:^$project.test\$" $cmd
end
