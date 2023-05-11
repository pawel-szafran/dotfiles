# My personal Dotfiles for macOS

## Install

Install [Homebrew](http://brew.sh/).

```console
brew install git
```

```console
git clone git@github.com:pawel-szafran/dotfiles.git && cd dotfiles
```

```console
brew bundle
```

```console
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
```

```console
chsh -s /opt/homebrew/bin/fish
```

Restart terminal.

```console
fish_add_path /opt/homebrew/bin/
```

Install [Fisher](https://github.com/jorgebucaran/fisher).

```console
source install.fish
```

```console
tu
```

## Update terminal setup

```console
tu
```
