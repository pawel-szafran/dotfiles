# My Personal Dotfiles

- These are my personal dotfiles for Mac OS X.
- The goal is to be able to easily keep my dotfiles in sync between different Macs.
- The goal is NOT to provide a single command that installs all the core terminal software I use, like iTerm or Homebrew, because I don't do that often, and I don't want to own their installation process, which might change over time.

## Get Started

1. Install [iTerm2](https://www.iterm2.com/)
1. Install [Solarized Dark for iTerm2](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
1. Install [Homebrew](http://brew.sh/)
1. `brew install git`
1. `brew install zsh`
1. `sudo chsh -s /usr/local/bin/zsh username`
1. Install [Prezto](https://github.com/sorin-ionescu/prezto)
1. `brew install tmux`
1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
1. Map *Caps Lock* to *Control*

## Install Dotfiles

1. `git clone https://github.com/pawel-szafran/dotfiles.git ~/Dev/dotfiles`
1. `ln -s ~/Dev/dotfiles ~/.dotfiles`
1. `source ~/.dotfiles/install.zsh`

## Update Dotfiles

1. `dfu`
