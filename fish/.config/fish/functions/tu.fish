##
## Update terminal setup
##

function tu
  cd $DOTFILES_DIR

  function tu_log
    echo (set_color blue)"=>" $argv[1](set_color normal)
  end

  for pkg in stow fish kitty git helix direnv lazygit broot
    tu_log "Symlinking $pkg"
    stow -v -t $HOME --no-folding --dotfiles $pkg
  end

  tu_log "Updating brew"
  brew update
  brew upgrade
  brew bundle
  brew autoremove
  brew cleanup

  tu_log "Updating mise"

  mise plugins update

  for tool in erlang elixir rust go node python
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

  functions -e tu_log
  cd -
  exec fish
end
