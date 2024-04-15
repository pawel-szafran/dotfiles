##
## GH browse that works on absolute paths
##

function hx_gh_browse
    set -f file (string replace "$PWD/" '' $argv[1])
    set -f branch (git rev-parse --abbrev-ref HEAD)
    gh browse -b $branch $file
end
