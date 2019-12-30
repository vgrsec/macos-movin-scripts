# MacOS Move In Scripts

## Overview

This is a collection of scripts for me to move into MacOS. It's split between computer level scripts and user level scripts. 

**Note** Apple is quick to change functionality. After each OS build it'd be prudent to test these in a VM to ensure predictable behavior

## Computer Scripts

These scripts setup a limited user account, and a filevault account. FileVault user is added to the disk to unlock it, but otherwise has no other access to the system.

The RandomHostname script randomizes the hostname on boot using `/usr/share/dict/words` as a data source.

The RandomMacAddress *should* randomize mac on boot, but there's a bug; something doesn't parse right on boot.

Network and Spotlight Scripts perform minor tweaks. 

## User Scripts

These scripts should be self explanatory with their function. 

## Thanks 

These repos helped me along the way
* https://github.com/arrelid/preferences/blob/master/defaults.sh
* https://github.com/sj26/home/blob/master/move-in-osx
* https://github.com/joeyhoer/starter/blob/master/apps/safari.sh