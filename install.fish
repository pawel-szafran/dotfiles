set modules  \
  utils      \
  fish       \
  git        \
  containers \
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
  set orig $module_dir/$argv[1]
  set slink $target_dir/$argv[1]
  echo "Linking: $slink -> $orig" 
  ln -sf $orig $slink
end

for module in $modules
  echo "→ Installing $module"
  set -g module_dir ~/.dotfiles/$module
  source $module/install.fish
  set -e module_dir
end

set -e modules
functions -e symlink
cd ~
brew cleanup
omf reload
