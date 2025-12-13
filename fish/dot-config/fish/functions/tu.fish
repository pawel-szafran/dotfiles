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

    for tool in erlang rust go node python lua-language-server zig
        mise install -y {$tool}@latest
        mise use -g --pin {$tool}@latest
    end

    # Elixir latest has no OTP ver, e.g. 1.18.4-otp-, so we need extra handling:
    set -l otp (string split -f1 . (mise latest erlang))
    set -l elixir_ver (string trim (mise latest elixir))
    set -l elixir_full_ver $elixir_ver$otp
    mise install -y elixir@$elixir_full_ver
    mise use -g --pin elixir@$elixir_full_ver

    tu_log "Updating cargo"
    for pkg in amber ccase
        cargo install $pkg
    end

    tu_log "Updating fisher"
    fisher update

    tu_log "Updating Yazi packages"
    ya pkg upgrade

    cd -
    exec fish
end
