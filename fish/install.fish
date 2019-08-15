symlink config.fish ~/.config/fish
symlink .hushlogin

omf update
omf install chain
omf theme chain

omf install   \
  open_github \
  asdf

asdf update
asdf plugin-update --all
