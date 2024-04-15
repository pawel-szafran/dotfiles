##
## Open broot
##

function hx_br
    set -f project (path basename (pwd))
    kitten @ launch --type overlay --window-title $project.br --cwd current --no-response --copy-env broot
end
