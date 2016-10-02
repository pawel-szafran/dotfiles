# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots/"
defaults write com.apple.screencapture disable-shadow -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.15

# Speed up Dock animation
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4

# Google Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

killall Dock
killall SystemUIServer
