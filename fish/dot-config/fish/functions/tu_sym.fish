function tu_sym -d "Update terminal setup symlinks"
    cd $DOTFILES_DIR

    for pkg in stow fish ghostty git glow helix tmux direnv lazygit btop yazi worktrunk
        tu_log "Symlinking $pkg"
        stow -v -t $HOME --no-folding --dotfiles $pkg
    end

    cd -
end
