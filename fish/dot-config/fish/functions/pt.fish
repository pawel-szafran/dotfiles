##
## Set project tab title
##

function pt
    set -f project (path basename (pwd))
    wezterm cli set-tab-title $project.$argv[1]
end
