##
## Snippets
##

function s
  switch $argv[1]
    case i
      while read line
        echo -n "|> IO.inspect(label: ~s<$line>)"
      end
    case ip
      while read line
        echo -n "|> IO.inspect(label: ~s<$line>, pretty: true)"
      end
    case if
      while read line
        echo -n "|> IO.inspect(label: ~s<$line>, pretty: true, limit: :infinity, printable_limit: :infinity)"
      end
  end
end
