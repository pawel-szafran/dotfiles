set modules  \
  mac        \
  utils      \
  fish       \
  git        \
  docker-k8s \
  iterm      \
  vscode

brew upgrade
brew cask upgrade

cd ~/.dotfiles

function symlink
  if set -q $argv[2]
    set target_dir ~
  else
    set target_dir $argv[2]
    mkdir -p $target_dir
  end
  ln -sf $module_dir/$argv[1] $target_dir/$argv[1]
end

for module in $modules
  echo "→ Installing $module"
  set module_dir ~/.dotfiles/$module
  source $module/install.fish
  set -e module_dir
end

set -e modules
functions -e symlink
cd ~
brew cleanup
omf reload
