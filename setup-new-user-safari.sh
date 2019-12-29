#!/bin/bash
#
### VGR - Move into a New Laptop 
#
### Safari Scripts 
### Changelog ###
#
# 20191228 Initial Breakout

### Safari

echo "Setup Safari"

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
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write ~/Library/Preferences/com.apple.Safari.plist AutoFillFromAddressBook -bool false
defaults write ~/Library/Preferences/com.apple.Safari.plist AutoFillPasswords -bool false
defaults write ~/Library/Preferences/com.apple.Safari.plist AutoFillMiscellaneousForms -bool false

# Disable websites from checking if Apple Pay is set up
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2ApplePayCapabilityDisclosureAllowed -bool false

# Start with a new private window
defaults write com.apple.Safari OpenPrivateWindowWhenNotRestoringSessionAtLaunch -bool true

# Prevent Safari from opening "safe" files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

killall Safari
