brew_cask_install atom

# Packages
function {
  local pkgs=(
    git-plus
    go-plus
    go-rename
    language-docker
  )
  for pkg in $pkgs; do
    if ! apm list -ib | grep "^$pkg@" >& /dev/null; then
      apm install $pkg
    fi
  done
}

# Symlinks
symlink_dir="$HOME/.atom"
symlink "config.cson"
symlink "keymap.cson"
symlink "snippets.cson"
unset symlink_dir
