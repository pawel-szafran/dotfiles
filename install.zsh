DFDIR=~/.dotfiles

# Symlinks
for file in $DFDIR/**/*.symlink
do
  ln -sf "$file" "$HOME/.${file:t:r}"
done
