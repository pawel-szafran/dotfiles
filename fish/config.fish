function fish_greeting
end

for configure_script in ~/.dotfiles/**/configure.fish
  source $configure_script
end

function dfu
  source ~/.dotfiles/install.fish
end

function mkdcd
  mkdir -p $argv && cd $argv
end
