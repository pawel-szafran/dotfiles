function c -d "Claude Code"
    zellij action rename-pane claude
    zellij_rename_default_tab claude
    claude $argv
end
