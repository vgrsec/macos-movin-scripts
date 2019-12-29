#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

##### System Privacy ######

# Limit AdTracking
defaults write com.apple.AdLib forceLimitAdTracking -boolean true

#Disable Spotlight Indexing

# audo mdutil -a -i off
echo " "
echo "Disable spotlight indexing and add /Volumes to exclusion in settings"
echo "Spotlight is now protected by SIP https://www.jamf.com/jamf-nation/discussions/29884/10-14-cannot-modify-spotlight-v100-volumeconfiguration-plist"

# Disable SpotLight Suggestion Search
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# Disable Spotlight from indexing pesky places like the internet
defaults write com.apple.Spotlight orderedItems -array \
'{"enabled" = 1;"name" = "APPLICATIONS";}' \
'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
'{"enabled" = 1;"name" = "DIRECTORIES";}' \
'{"enabled" = 0;"name" = "PDF";}' \
'{"enabled" = 0;"name" = "FONTS";}' \
'{"enabled" = 0;"name" = "DOCUMENTS";}' \
'{"enabled" = 0;"name" = "MESSAGES";}' \
'{"enabled" = 0;"name" = "CONTACT";}' \
'{"enabled" = 0;"name" = "EVENT_TODO";}' \
'{"enabled" = 0;"name" = "IMAGES";}' \
'{"enabled" = 0;"name" = "BOOKMARKS";}' \
'{"enabled" = 0;"name" = "MUSIC";}' \
'{"enabled" = 0;"name" = "MOVIES";}' \
'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
'{"enabled" = 0;"name" = "SOURCE";}' \
'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
'{"enabled" = 0;"name" = "MENU_OTHER";}' \
'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
