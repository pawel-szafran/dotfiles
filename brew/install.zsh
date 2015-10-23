function brew_check {
  brew list -1 | grep "^$1$" &> /dev/null
}

function brew_install {
  brew_check $1 || brew install $1
}

brew_check brew-cask || brew install caskroom/cask/brew-cask
