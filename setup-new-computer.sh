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

# This ensures the script runs with sudo.
 
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi

# It's assumed here this is being run on a new laptop
# from the user created during the first boot wizard

FILEVAULT="./setup-new-computer-filevault.sh"
. "$FILEVAULT"

NETWORK="./setup-new-computer-network.sh"
. "$NETWORK"

RANDOMHOSTNAME="./setup-new-computer-randomhostname.sh"
. "$RANDOMHOSTNAME"

RANDOMMAC="./setup-new-computer-randommac.sh"
. "$RANDOMMAC"

SPOTLIGHT="./setup-new-computer-spotlight.sh"
. "$SPOTLIGHT"
