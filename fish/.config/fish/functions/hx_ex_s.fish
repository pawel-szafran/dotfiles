##
## Elixir: snippets
##

function hx_ex_s
    switch $argv[1]
        case i
            while read -l line
                echo -n "|> IO.inspect(label: ~s<$line>)"
            end
        case ip
            while read -l line
                echo -n "|> IO.inspect(label: ~s<$line>, pretty: true)"
            end
        case if
            while read -l line
                echo -n "|> IO.inspect(label: ~s<$line>, pretty: true, limit: :infinity, printable_limit: :infinity)"
            end
        case ifr
            while read -l line
                echo -n "|> IO.inspect(label: ~s<$line>, pretty: true, limit: :infinity, printable_limit: :infinity, structs: false)"
            end
    end
end
