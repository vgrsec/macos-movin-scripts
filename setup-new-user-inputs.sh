#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### Inputs ######


#### Keyboard & Mouse ####################################

# This sets scroll to "unnatural"
defaults write -g com.apple.swipescrolldirection -bool NO

# Speed up mouse tracking speed
defaults write -g com.apple.mouse.scaling 3

# Set keyboard repeat rate to "damn fast".
defaults write NSGlobalDomain KeyRepeat -int 2

# Set a shorter delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

