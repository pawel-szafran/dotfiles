##
## Set up project tab
##

function p
    if set -q argv[1]
        z $argv[1]
    end

    set -f project (path basename (pwd))
    wezterm cli set-tab-title $project
    hx .
end
