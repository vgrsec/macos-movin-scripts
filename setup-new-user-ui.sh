#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### UI ######

# Show bluetooth icon and sound
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write ~/Library/Preferences/com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.systemuiserver menuExtras '
(
    "/System/Library/CoreServices/Menu Extras/Volume.menu",
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
)'

# Show Battery Percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Desktops and Mission Control Top Right Corner
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# Lock Screen Bottom Left Corner
defaults write com.apple.dock wvous-bl-corner -int 13
defaults write com.apple.dock wvous-bl-modifier -int 0

# Go to Desktop Bottom Right Corner
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Require password when screensaver is started
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Reset UI
killall SystemUIServer
