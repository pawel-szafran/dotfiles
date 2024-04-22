##
## Update terminal setup
##

function tu
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

    for tool in erlang elixir rust go node python lua-language-server
        mise install -y {$tool}@latest
        mise use -g --pin {$tool}@latest
    end

    tu_log "Updating cargo"
    for pkg in amber ccase
        cargo install $pkg
    end

    tu_log "Updating tldr (h)"
    tldr --update

    tu_log "Updating fisher"
    fisher update

    cd -
    exec fish
end
