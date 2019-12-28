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

### System Privacy

# Limit AdTracking
defaults write com.apple.AdLib forceLimitAdTracking -boolean true

### Safari

# Disable DNS Prefetching
defaults write com.apple.safari WebKitPreferences.dnsPrefetchingEnabled -boolean false

# Disable favicon cache
rm ~/Library/Safari/WebpageIcons.db
defaults write com.apple.Safari WebIconDatabaseEnabled -bool false

# Disable resume
defaults write com.apple.Safari NSQuitAlwaysKeepsWindows -int 0

# Enable Debug Menu
defaults write com.apple.Safari IncludeInternalDebugMenu 1

# Disable ApplePay
defaults write com.apple.Safari WebKitPreferences.applePayEnabled -bool false

# Disable Private Windows from recovering
defaults write com.apple.Safari ExcludePrivateWindowWhenRestoringSessionAtLaunch -bool true

# Open blank new tabs and windows
defaults write com.apple.Safari NewTabBehavior 1
defaults write com.apple.Safari NewWindowBehavior 1

# Disable Preloading
defaults write com.apple.Safari PreloadTopHit -bool false

# Disable Quick Website Search
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false

# Disable Safari Search Suggestions
defaults write com.apple.Safari UniversalSearchEnabled -bool false

# Disable Search Engine Suggestions
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Set Search to DuckDuckGo
defaults write com.apple.Safari SearchProviderIdentifier -string com.duckduckgo

# Disable Fraudulent Websites Warnings (Submits to Google)
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool false

# Set History to 1 Day
defaults write com.apple.Safari HistoryAgeInDaysLimit 1

# Show full URL
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Disable AutoFill
defaults write com.apple.Safari AutoFillCreditCardData -bool true
defaults write com.apple.Safari AutoFillFromAddressBook -bool true
defaults write com.apple.Safari AutoFillPasswords -bool true
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool true

# Allow websites to check if Apple Pay is set up
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2ApplePayCapabilityDisclosureAllowed -bool false


#### Keyboard & Mouse ####################################

# This sets scroll to "unnatural"
defaults write -g com.apple.swipescrolldirection -bool NO

# Speed up mouse tracking speed
defaults write -g com.apple.mouse.scaling 3

# Set keyboard repeat rate to "damn fast".
defaults write NSGlobalDomain KeyRepeat -int 2

# Set a shorter delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Start with a new private window
defaults write com.apple.Safari OpenPrivateWindowWhenNotRestoringSessionAtLaunch -bool true

# Prevent Safari from opening "safe" files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

killall Safari

##### Finder ######

# Show Hidden Files in Finder
defaults write com.apple.Finder AppleShowAllFiles true

# Don't create dreaded .DS_Store files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Show absolute path in Finder's title bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# New Finder windows points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Use plain text for new documents in TextEdit.app
defaults write com.apple.TextEdit RichText -bool false
killall Finder

# Show bluetooth icon and sound
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write ~/Library/Preferences/com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.systemuiserver menuExtras '
(
    "/System/Library/CoreServices/Menu Extras/Volume.menu",
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
)'
# Show Battery Percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Do not show recent applications in dock
defaults write com.apple.dock show-recent -bool false

# Minimize Applications to dock icon
defaults write com.apple.dock minimize-to-application -bool true


# Reset UI
killall SystemUIServer

# Desktops and Mission Control Top Right Corner
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# Lock Screen Bottom Left Corner
defaults write com.apple.dock wvous-bl-corner -int 13
defaults write com.apple.dock wvous-bl-modifier -int 0

# Go to Desktop Bottom Right Corner
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Require password when screensaver is started
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#Disable Spotlight Indexing
# audo mdutil -a -i off
echo " "
echo "Disable spotlight indexing and add /Volumes to exclusion in settings"
echo "Spotlight is now protected by SIP https://www.jamf.com/jamf-nation/discussions/29884/10-14-cannot-modify-spotlight-v100-volumeconfiguration-plist"
