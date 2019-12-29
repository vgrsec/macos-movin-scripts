#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Computer Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### Users and FileVault Setup ######

echo "Setup FileVault and Users"

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
