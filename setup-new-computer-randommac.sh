#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Computer Setup Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### RandomMAC ######

echo "Setup RandomMAC"

# Setup Directories
mkdir /usr/local
mkdir /usr/local/bin

# Randomize MAC Address on boot
cp ./randommacaddress.sh /usr/local/bin/randommacaddress.sh
cp ./com.randommacaddress.plist /Library/LaunchDaemons/com.randommacaddress.plist
launchctl load -w /Library/LaunchDaemons/com.randommacaddress.plist