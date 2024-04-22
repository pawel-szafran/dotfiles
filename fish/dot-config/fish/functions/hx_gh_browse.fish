##
## GH browse that works on absolute paths
##

function hx_gh_browse
    set -f file (string replace "$PWD/" '' $argv[1])

    if set -q argv[2]
        set -f branch $argv[2]
    else
        set -f branch (git rev-parse --abbrev-ref HEAD)
    end

    gh browse -b $branch $file
end
