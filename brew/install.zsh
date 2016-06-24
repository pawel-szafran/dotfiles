function brew_check {
  brew list -1 2>&1 | grep "^$1$" >& /dev/null
}

function brew_install {
  brew_check $1 || brew install $1
}

function brew_cask_check {
  brew cask list -1 2>&1 | grep "^$1$" >& /dev/null
}

function brew_cask_install {
  brew_cask_check $1 || brew cask install $1
}
