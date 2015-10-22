function symlink {
  local target_dir=${symlink_dir-$HOME}
  ln -sf "$module_dir/$1" "$target_dir/$1"
}

for module_script in ~/.dotfiles/*/**/install.zsh(N); do
  module_dir=${module_script:h}
  source "$module_script"
  unset module_dir
done

unset -f symlink
