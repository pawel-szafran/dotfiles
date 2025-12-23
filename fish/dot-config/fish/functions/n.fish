function n -d "Open notes"
    z notes
    zellij action rename-session notes
    set -gx ZELLIJ_SESSION_NAME notes
    zellij action rename-tab notes
    exec hx .
end
