function symlink {
  local target_dir=${symlink_dir-$HOME}
  ln -sf "$module_dir/$1" "$target_dir/$1"
}

function {
  local modules_to_install=(
    mac
    zsh
    brew
    git
    go
    tmux
    atom
    cloud
    util
  )
  for module in $modules_to_install; do
    echo "→ Installing $module"
    local module_install_script="$HOME/.dotfiles/$module/install.zsh"
    local module_dir=${module_install_script:h}
    source $module_install_script
  done
}

unset -f symlink

for file in ~/.dotfiles/**/unset.zsh(N); do
  source $file
done
