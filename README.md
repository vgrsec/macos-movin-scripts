# MacOS Move In Scripts

## Overview

This is a collection of scripts for me to move into MacOS. It's split between computer level scripts and user level scripts. 

**Note** Apple is quick to change functionality. After each OS build it'd be prudent to test these in a VM to ensure predictable behavior

**2025 Note**
I've refactored this so that it now works on the latest version of MacOS. Many of these commands have now been sourced from LLMs.

## Computer Scripts

These scripts setup a limited user account, and a filevault account. FileVault user is added to the disk to unlock it, but otherwise has no other access to the system.

The RandomHostname script randomizes the hostname on boot using `/usr/share/dict/words` as a data source.


## User Scripts

These scripts should be self explanatory with their function. 

## Finding Settings

1. In one terminal window run
	```
	sudo fs_usage -w | grep -E "Preferences/.*\.plist"
	```
1. Change the setting you're looking to have changed
1. Determine where the plist file lives
  1. If the plist is located in /System/Volumes/Data/Users/$USERNAME/Library/Preferences/ByHost/com.apple.$SERVICE.$GUID.plist
    1. Run `defaults -currentHost read com.apple.$SERVICE to find the key
    1. Set the setting back to original state
    1. Run `defaults -currentHost write com.apple.$SERVICE $KEY` to change the setting in code
    1. Confirm the setting is changed to what you want it to be

## Configuration Tasks Performed by Scripts

### `user-setup.sh`
- **General Preferences**: Applies user-level settings to optimize mouse, trackpad, and keyboard responsiveness.
- **Scrolling & Tracking**: Disables natural scroll direction and increases mouse tracking speed for a more traditional feel.
- **Keyboard Behavior**: Disables press-and-hold in favor of fast key repeat, sets a short delay before repeats, and speeds up key repeat rate.
- **Text Input Tweaks**: Turns off automatic capitalization, smart quotes, smart dashes, and period substitution to prevent unwanted formatting when coding.
- **Interface & Finder UI**: Reduces Menu Bar padding, expands the save dialog by default, and configures Finder to show hidden files, use list view sorted by kind.
- **Dock & Menubar**: Removes recent items from the Dock, enables minimizing windows into app icons, shows Bluetooth in the Menu Bar, and adds the Applications folder as a Dock stack.
- **Security Lock**: Requires immediate password entry when the screensaver activates or the display sleeps.
- **SSH Directory Migration**: Moves the `~/.ssh` directory to a secure backup location and creates a symlink for seamless access.

### `computer-setup.sh`
- **Privilege Enforcement**: Verifies script is run as root to apply system-level changes.
- **FileVault Management**: Lists current FileVault users and provides an interface to remove unwanted users.
- **Host & Network Randomization**: Installs and enables LaunchDaemons to randomize the hostname and MAC address at boot.
- **Login & Lockdown Policies**: Enforces login requirements (both username and password), removes Guest account and auto-login, and applies per-user password and screensaver lock settings.
- **Power Management**: Enables Low Power Mode, sets display sleep to 15 minutes, disables system sleep, and configures power settings for optimal battery life.
- **iCloud Integration**: Symlinks each user’s Downloads folder to `~/Documents/Downloads` so that downloads are automatically uploaded to iCloud.


## Thanks 

These repos helped me along the way
* https://github.com/arrelid/preferences/blob/master/defaults.sh
* https://github.com/sj26/home/blob/master/move-in-osx
* https://github.com/joeyhoer/starter/blob/master/apps/safari.sh