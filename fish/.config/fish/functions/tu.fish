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
    stow -v -t $HOME --dotfiles $pkg
  end

  tu_log "Updating brew"
  brew update
  brew upgrade
  brew bundle
  brew autoremove
  brew cleanup

  tu_log "Updating asdf"

  asdf plugin update --all

  for plugin in erlang elixir rust nodejs yarn python
    asdf plugin add $plugin
    asdf install $plugin latest
    asdf global $plugin latest
  end

  asdf reshim

  tu_log "Updating cargo"
  for pkg in amber
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
