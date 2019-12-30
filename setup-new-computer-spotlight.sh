#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Computer Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

### SpotLight ###
echo "Setup SpotLight"

# Disable Spotlight
mdutil -a -i off
rm -rf /.Spotlight-V100/*

# Disable SpotLight Suggestion Search
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

