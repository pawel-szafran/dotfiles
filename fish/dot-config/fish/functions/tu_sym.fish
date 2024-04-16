##
## Update terminal setup symlinks
##

function tu_sym
    cd $DOTFILES_DIR

    for pkg in stow fish kitty git helix direnv lazygit broot
        tu_log "Symlinking $pkg"
        stow -v -t $HOME --no-folding --dotfiles $pkg
    end

    cd -
end
