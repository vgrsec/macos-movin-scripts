#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Breakout


##### Finder ######

echo "Setup Finder"

# Show Hidden Files in Finder
defaults write com.apple.Finder AppleShowAllFiles true

# Don't create dreaded .DS_Store files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Show absolute path in Finder's title bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# New Finder windows points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Use plain text for new documents in TextEdit.app
defaults write com.apple.TextEdit RichText -bool false

killall Finder
