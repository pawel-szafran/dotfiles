function {
  local utils=(
    tree
    wget
    htop
    httpie
  )
  for util in $utils; do
    brew_install $util
  done
}
