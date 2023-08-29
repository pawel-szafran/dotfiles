##
## Env vars
##

set -gx EDITOR 'hx'
set -gx BAT_THEME 'ansi'

# Elixir
set -gx ERL_AFLAGS '-kernel shell_history enabled'

##
## Aliases
##

# Change `ls` to `exa`
alias ls='exa --color=always --group-directories-first --icons'
alias ll='exa -l --color=always --group-directories-first --icons'
alias la='ll -a'
alias lt='exa -T --color=always --group-directories-first --icons'
alias lta='lt -a'

alias j='z'
alias h='tldr'
alias lg='lazygit'

##
## Interactive
##

if status is-interactive

  # Prompt
  set hydro_multiline true
  set hydro_color_prompt '#b58900'

  # Vi mode
  fish_vi_key_bindings

  # asdf
  source /opt/homebrew/opt/asdf/libexec/asdf.fish

  # direnv
  direnv hook fish | source
end

##
## Unversioned work config
##

if test -e ~/.config/fish/work.fish
  source ~/.config/fish/work.fish
end
