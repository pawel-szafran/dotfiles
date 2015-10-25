if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
else
  cd ~/.zprezto
  git pull && git submodule update --init --recursive
  popd
fi

symlink ".zpreztorc"
symlink ".zprofile"
symlink ".zshenv"
symlink ".zshrc"
symlink ".hushlogin"

source ~/.zshenv
source ~/.zprofile
source ~/.zshrc
