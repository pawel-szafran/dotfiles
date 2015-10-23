function symlink {
  local target_dir=${symlink_dir-$HOME}
  ln -sf "$module_dir/$1" "$target_dir/$1"
}

modules_to_install=(
  zsh
  brew
  tmux
)
for module in $modules_to_install; do
  module_install_script="$HOME/.dotfiles/$module/install.zsh"
  module_dir=${module_install_script:h}
  source $module_install_script
  unset module_install_script
  unset module_dir
done
unset modules_to_install

unset -f symlink

for file in ~/.dotfiles/**/unset.zsh(N); do
  source $file
done
