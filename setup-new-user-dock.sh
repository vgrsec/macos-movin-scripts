#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### Dock ######

# Do not show recent applications in dock
defaults write com.apple.dock show-recent -bool false

# Minimize Applications to dock icon
defaults write com.apple.dock minimize-to-application -bool true

# Clean up the Dock
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# Terminal
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Utilities/Terminal.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

# Safari
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Safari.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

# Messages
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Messages.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

# Maps
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Maps.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

# Calendar
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Calendar.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

# Add Applications to Dock
defaults write com.apple.dock persistent-others -array-add '<dict><key>tile-data</key><dict><key>showas</key><integer>0</integer><key>file-type</key><integer>2</integer><key>file-data</key><dict><key>_CFURLStringType</key><integer>15</integer><key>_CFURLString</key><string>file:///Applications/</string></dict><key>displayas</key><integer>0</integer><key>file-label</key><string>Applications</string><key>arrangement</key><integer>1</integer><key>preferreditemsize</key><integer>-1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>'

killall Dock