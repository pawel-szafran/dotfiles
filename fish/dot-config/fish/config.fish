##
## Env vars
##

set -gx EDITOR hx
set -gx BAT_THEME ansi

# Elixir
set -gx ERL_AFLAGS '-kernel shell_history enabled'

##
## Path
##

fish_add_path ~/.local/share/mise/installs/rust/(mise current -C ~ rust)/bin

##
## Aliases
##

# Change `ls` to `eza`
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias la='ll -a'
alias lt='eza -T --color=always --group-directories-first --icons'
alias lta='lt -a'

alias j='z'
alias h='tldr'
alias lg='lazygit'

##
## Interactive
##

if status is-interactive
    # prompt
    set hydro_multiline true
    set hydro_color_prompt '#b58900'

    # bindings
    fish_default_key_bindings

    # mise
    mise activate fish | source

    # direnv
    direnv hook fish | source

    # fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND fd
    set -gx FZF_CTRL_T_COMMAND fd
    set -gx FZF_DEFAULT_OPTS '-m --reverse'
end

##
## Unversioned work config
##

if test -e ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end
