#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Changelog ###
#
### 20181231 - Wrote Script
### 20191202 - Updated Script for 10.15
#
# Some defaults from: 
# https://github.com/arrelid/preferences/blob/master/defaults.sh
# https://github.com/sj26/home/blob/master/move-in-osx
# https://github.com/joeyhoer/starter/blob/master/apps/safari.sh
# https://gist.github.com/Tristor/d3c699d16f6c1bbeec8f4c9d647a1f24

FINDER="./setup-new-user-finder.sh"
. "$FINDER"

SAFARI="./setup-new-user-safari.sh"
. "$SAFARI"

DOCK="./setup-new-user-dock.sh"
. "$DOCK"

INPUTS="./setup-new-user-inputs.sh"
. "$INPUTS"

UI="./setup-new-user-ui.sh"
. "$UI"

PRIVACY="./setup-new-user-privacy.sh"
. "$PRIVACY"

shutdown -r now