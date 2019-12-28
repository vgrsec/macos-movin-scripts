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

# The goal of the following code is to perform the following
#
# 1. Setup a filevault user who is unable to login but is able to unlock the disk
# 2. Remove the user created during first boot from filevault
# 3. Create a limited user for day to day use.

CURRENTUSER="$(ls /Users | sed 's/Shared//g' | sed 's/\.localized//g')"
echo "Current user is "$CURRENTUSER

# It's assumed here this is being run on a new laptop
# from the user created during the first boot wizard

# The goal of the following code is to perform the following
#
# 1. Setup a filevault user who is unable to login but is able to unlock the disk
# 2. Remove the user created during first boot from filevault
# 3. Create a limited user for day to day use.

PASSWORDMATCH="0"
while [ $PASSWORDMATCH -eq 0 ]
do
    echo "Set FileVault Password"
    read -s PASSWORD1
    echo "Confirm FileVault Password"
    read -s PASSWORD2
    if [ "$PASSWORD1" == "$PASSWORD2" ]; then
        PASSWORDMATCH="1"
        echo "success"
    else
        echo "fail"
    fi
done

echo "Enter username for limited user"
read LIMITEDUSER

sysadminctl -addUser $LIMITEDUSER -fullName $LIMITEDUSER
sysadminctl -addUser filevault -fullName filevault -password "$PASSWORD1" -secureTokenOn
pwpolicy -u $LIMITEDUSER -setpolicy "newPasswordRequired=1"
sysadminctl -guestAccount Off
sysadminctl -secureTokenOn filevault -password - -adminUser $(logname) -adminPassword -
fdesetup enable -user filevault
fdesetup remove -user alice
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool false
chsh -s /usr/bin/false filevault

# Randomize hostname on boot

mkdir /usr/local/bin
cp ./randomhostname.sh /usr/local/bin/randomhostname.sh
cp ./com.randomhostname.plist /Library/LaunchDaemons/com.randomhostname.plist
launchctl load -w /Library/LaunchDaemons/com.randomhostname.plist

# Randomize MAC Address on boot
cp ./randommacaddress.sh /usr/local/bin/randommacaddress.sh
cp ./com.randommacaddress.plist /Library/LaunchDaemons/com.randommacaddress.plist
launchctl load -w /Library/LaunchDaemons/com.randommacaddress.plist

# Enable Firewall

defaults write /Library/Preferences/com.apple.alf globalstate -int 2

# Disable Spotlight
mdutil -a -i off
rm -rf /.Spotlight-V100/*

# Disable ipv6
networksetup -setv6off Wi-Fi

# Set Screensaver Password to Start
echo "Setting screensaver security is broken in 10.13+"
echo "See https://blog.kolide.com/screensaver-security-on-macos-10-13-is-broken-a385726e2ae2"
defaults -currentHost write com.apple.screensaver askForPasswordDelay 0
defaults write com.apple.screensaver askForPassword -bool true
