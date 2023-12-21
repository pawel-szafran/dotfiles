source macos.fish
stow -v -t $HOME --no-folding --dotfiles stow
stow -v -t $HOME --no-folding --dotfiles fish
fisher update
set -U DOTFILES_DIR (pwd)

exec fish
