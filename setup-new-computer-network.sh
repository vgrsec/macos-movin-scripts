#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Computer Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### Network Tweaks ######

echo "Setup Network"

# Enable Firewall
defaults write /Library/Preferences/com.apple.alf globalstate -int 2

# Disable ipv6
networksetup -setv6off Wi-Fi
networksetup -setv6off Ethernet