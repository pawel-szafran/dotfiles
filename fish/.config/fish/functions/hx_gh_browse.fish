##
## GH browse that works on absolute paths
##

function hx_gh_browse
    set -f file (string replace "$PWD/" '' $argv[1])
    gh browse $file
end
