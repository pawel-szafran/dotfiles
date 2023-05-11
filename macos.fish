# Screenshots
mkdir -p ~/Screenshots/
defaults write com.apple.screencapture location -string "$HOME/Screenshots/"
defaults write com.apple.screencapture disable-shadow -bool true

# Speed up Dock animation
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4

killall Dock
killall SystemUIServer
