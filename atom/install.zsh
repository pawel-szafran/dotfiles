brew_cask_install atom	

# Packages
pkgs=(
  git-plus
  go-plus
  go-rename
)
for pkg in $pkgs; do
  if ! apm list -ib | grep "^$pkg@" >& /dev/null; then
    apm install $pkg
  fi
done
unset pkgs

# Symlinks
symlink_dir="$HOME/.atom"
symlink "config.cson"
symlink "keymap.cson"
unset symlink_dir
