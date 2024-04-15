##
## Open dotfiles
##

function dot
    j dotfiles

    kitten @ set-window-title dotfiles.lg
    kitten @ launch --type window --window-title dotfiles.hx --cwd current --dont-take-focus --no-response --copy-env fish -C 'hx .'

    lg
end
