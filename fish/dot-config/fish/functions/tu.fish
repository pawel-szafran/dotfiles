function tu -d "Update terminal setup"
    tu_sym

    cd $DOTFILES_DIR

    tu_log "Updating brew"
    brew update
    brew upgrade
    brew bundle
    brew autoremove
    brew cleanup

    tu_log "Updating mise"

    mise plugins update

    for tool in erlang elixir rust go node python lua-language-server zig
        mise use -g --pin {$tool}@latest
    end

    tu_log "Updating cargo"
    for pkg in amber ccase
        cargo install $pkg
    end

    tu_log "Updating fisher"
    fisher update

    tu_log "Updating Yazi packages"
    for pkg in yazi-rs/plugins:smart-enter yazi-rs/plugins:toggle-pane yazi-rs/flavors:catppuccin-frappe
        ya pkg add $pkg
    end
    ya pkg upgrade

    cd -
    exec fish
end
