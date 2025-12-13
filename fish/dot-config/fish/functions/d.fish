##
## Droid
##

function d
    zellij action rename-pane droid
    zellij_rename_default_tab droid
    droid $argv
end
