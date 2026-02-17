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
## Config
##

ulimit -n 8192

##
## Interactive
##

if status is-interactive

    # Change `ls` to `eza`
    alias ls='eza --color=always --group-directories-first --icons'
    alias ll='eza -l --color=always --group-directories-first --icons'
    alias la='ll -a'
    alias lt='eza -T --color=always --group-directories-first --icons'
    alias lta='lt -a'
    alias top='btop'

    abbr -a o open
    abbr -a j just
    abbr -a g lazygit
    abbr -a lzg lazygit
    abbr -a lzd lazydocker
    abbr -a t tmux
    abbr -a t tmux
    abbr -a calc fend

    abbr -a wts wt switch
    abbr -a wtc wt switch -c
    abbr -a wtl wt list
    abbr -a wtr wt remove

    abbr -a c claude
    abbr -a d droid
    abbr -a r ralph-tui

    ## bindings
    fish_default_key_bindings

    ## mise
    mise activate fish | source

    # Keep custom bin dirs at the front of PATH after mise reshims on cd
    function __ensure_bin_overrides --on-event fish_prompt
        set -l bins $HOME/.local/bin $HOME/.bun/bin
        set -l needs_fix false
        for i in (seq (count $bins))
            if test "$PATH[$i]" != "$bins[$i]"
                set needs_fix true
                break
            end
        end
        if test "$needs_fix" = true
            set -l filtered $PATH
            for b in $bins
                set filtered (string match -v -- $b $filtered)
            end
            set -gx PATH $bins $filtered
        end
    end

    ## direnv
    direnv hook fish | source

    ## zoxide
    zoxide init fish | source

    ## fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND fd
    set -gx FZF_CTRL_T_COMMAND fd
    set -gx FZF_DEFAULT_OPTS '-m --reverse'

end

##
## Path
##

fish_add_path -P ~/.local/bin
fish_add_path -P ~/.bun/bin

##
## Unversioned work config
##

if test -e ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end
