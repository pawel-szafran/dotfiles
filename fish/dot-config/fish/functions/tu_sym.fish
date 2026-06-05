function tu_sym -d "Update terminal setup symlinks"
    cd $DOTFILES_DIR

    tu_log Symlinking
    for pkg in stow fish ghostty git glow helix tmux lazygit btop yazi worktrunk lazydocker
        stow -v -t $HOME --no-folding --dotfiles $pkg
    end

    cd -
end
