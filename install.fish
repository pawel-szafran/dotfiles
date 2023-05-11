source macos.fish
stow -v -t $HOME --dotfiles stow
stow -v -t $HOME --dotfiles fish
fisher update
set -U DOTFILES_DIR (pwd)

exec fish
