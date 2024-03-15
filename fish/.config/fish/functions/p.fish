##
## Set up project tab
##

function p
    if set -q argv[1]
        j $argv[1]
    end

    set -f dir (pwd)
    set -f project (path basename $dir)

    kitten @ set-window-title $project.lg
    kitten @ launch --cwd $dir --type window --window-title $project.test --dont-take-focus --no-response
    kitten @ launch --cwd $dir --type window --window-title $project.hx --dont-take-focus --no-response

    kitten @ send-text --match "title:^$project.hx\$" "hx .\n"

    lg
end
