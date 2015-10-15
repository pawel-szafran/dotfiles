ZHOME=${ZDOTDIR:-$HOME}
DFDIR=$ZHOME/.dotfiles

# Symlinks
for file in $DFDIR/**/*.symlink
do
  ln -sf "${file}" "$ZHOME/.${file:t:r}"
done
