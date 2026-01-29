##
## Env vars
##

set -gx EDITOR hx
set -gx BAT_THEME ansi

# Gum theme (Everforest)
set -gx GUM_CHOOSE_CURSOR_FOREGROUND "#a7c080"
set -gx GUM_CHOOSE_SELECTED_FOREGROUND "#a7c080"
set -gx GUM_CHOOSE_HEADER_FOREGROUND "#83c092"
set -gx GUM_INPUT_CURSOR_FOREGROUND "#a7c080"
set -gx GUM_INPUT_PROMPT_FOREGROUND "#83c092"
set -gx GUM_CONFIRM_PROMPT_FOREGROUND "#83c092"
set -gx GUM_CONFIRM_SELECTED_FOREGROUND "#2d353b"
set -gx GUM_CONFIRM_SELECTED_BACKGROUND "#a7c080"
set -gx GUM_CONFIRM_UNSELECTED_FOREGROUND "#d3c6aa"
set -gx GUM_CONFIRM_UNSELECTED_BACKGROUND "#343f44"

# Elixir
set -gx ERL_AFLAGS '-kernel shell_history enabled'

##
## Path
##

fish_add_path ~/.local/bin

##
## Aliases
##

# Change `ls` to `eza`
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias la='ll -a'
alias lt='eza -T --color=always --group-directories-first --icons'
alias lta='lt -a'
alias top='btop'

abbr -a j just
abbr -a g lazygit
abbr -a lzg lazygit
abbr -a lzd lazydocker
abbr -a t tmux

abbr wts wt switch
abbr wtc wt switch --create
abbr wtl wt list
abbr wtr wt remove

abbr -a c claude
abbr -a d droid
abbr -a r ralph

##
## Config
##

ulimit -n 1024

##
## Interactive
##

if status is-interactive
    # bindings
    fish_default_key_bindings

    # mise
    mise activate fish | source

    # direnv
    direnv hook fish | source

    # zoxide
    zoxide init fish | source

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
