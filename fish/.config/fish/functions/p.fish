##
## Set up project tab
##

function p
    if set -q argv[1]
        j $argv[1]
    end

    set -f project (path basename (pwd))

    kitten @ set-window-title $project.lg
    kitten @ launch --type window --window-title $project.test --cwd current --dont-take-focus --no-response --copy-env
    kitten @ launch --type window --window-title $project.hx --cwd current --dont-take-focus --no-response --copy-env fish -C 'hx .'

    lg
end
