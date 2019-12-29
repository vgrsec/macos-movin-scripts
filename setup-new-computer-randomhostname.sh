#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Computer Setup Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### Random HostName ######

# Setup Directories
mkdir /usr/local
mkdir /usr/local/bin

# Randomize hostname on boot
cp ./randomhostname.sh /usr/local/bin/randomhostname.sh
cp ./com.randomhostname.plist /Library/LaunchDaemons/com.randomhostname.plist
launchctl load -w /Library/LaunchDaemons/com.randomhostname.plist
