function hx_jump_test -d "Jump between implementation and test files"
    set -l file $argv[1]

    switch $file
        case 'test/*_test.exs'
            string replace -r '^test/(.+)_test\.exs$' 'lib/$1.ex' $file
        case 'lib/*.ex'
            string replace -r '^lib/(.+)\.ex$' 'test/$1_test.exs' $file
        case '*'
            echo $file
    end
end
