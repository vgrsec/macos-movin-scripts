#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Scripts
# 20250515 Updates

##### UI ######
echo "setting up some preferences"

#### Keyboard & Mouse ####################################

echo "This sets scroll to unnatural"
defaults write -g com.apple.swipescrolldirection -bool NO

echo "Disable Natural Scroll"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Speed up mouse tracking speed"
defaults write -g com.apple.mouse.scaling 3

echo "Disable press and hold behavior"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Set keyboard repeat rate to fast"
defaults write NSGlobalDomain KeyRepeat -int 2

echo "Set a shorter delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false


echo "Make MenuBar items have less padding"
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 4
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 4

echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Require password when screensaver is started"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###### This isn't working ###
# # Swap Command and Control keys on the laptop keyboard
# # 1) Remove any previous mappings
# defaults -currentHost delete -g "com.apple.keyboard.modifiermapping." 2>/dev/null || true
# defaults -currentHost delete -g "com.apple.keyboard.modifiermapping.0-0-0" 2>/dev/null || true

# # 2) Write a generic override for ALL keyboards using the internal keyboard's usage codes
# defaults -currentHost write -g "com.apple.keyboard.modifiermapping." -array \
#   '{"HIDKeyboardModifierMappingSrc"=30064771296;"HIDKeyboardModifierMappingDst"=30064771299;}' \
#   '{"HIDKeyboardModifierMappingSrc"=30064771299;"HIDKeyboardModifierMappingDst"=30064771296;}' \
#   '{"HIDKeyboardModifierMappingSrc"=30064771300;"HIDKeyboardModifierMappingDst"=30064771303;}' \
#   '{"HIDKeyboardModifierMappingSrc"=30064771303;"HIDKeyboardModifierMappingDst"=30064771300;}'

# # 3) Reload the prefs daemon so the plist is up to date
# killall cfprefsd

# # 4) Immediately push the mapping into the running HID layer  
# hidutil property --set '{
#   "UserKeyMapping": [
#     {"HIDKeyboardModifierMappingSrc":30064771296,"HIDKeyboardModifierMappingDst":30064771299},
#     {"HIDKeyboardModifierMappingSrc":30064771299,"HIDKeyboardModifierMappingDst":30064771296},
#     {"HIDKeyboardModifierMappingSrc":30064771300,"HIDKeyboardModifierMappingDst":30064771303},
#     {"HIDKeyboardModifierMappingSrc":30064771303,"HIDKeyboardModifierMappingDst":30064771300}
#   ]
# }'

echo "Show Bluetooth in Menu Bar"
defaults -currentHost write com.apple.controlcenter Bluetooth -int 2
echo "Show Battery Percentage in Menu Bar"
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -int 1
echo "Show Energy Mode"
defaults -currentHost write com.apple.controlcenter BatteryShowEnergyMode -int 1
echo "Hide Spotlight"
defaults -currentHost write com.apple.spotlight MenuItemHidden -int 1

echo "Setup Dock"

echo "Do not show recent applications in dock"
defaults write com.apple.dock show-recent -bool false

echo "Minimize Applications to dock icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "Remove all items from dock"
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others
defaults write com.apple.dock show-recents -bool false

echo "Add Applications to Dock"
defaults write com.apple.dock persistent-others -array-add '<dict><key>tile-data</key><dict><key>showas</key><integer>0</integer><key>file-type</key><integer>2</integer><key>file-data</key><dict><key>_CFURLStringType</key><integer>15</integer><key>_CFURLString</key><string>file:///Applications/</string></dict><key>displayas</key><integer>0</integer><key>file-label</key><string>Applications</string><key>arrangement</key><integer>1</integer><key>preferreditemsize</key><integer>-1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>'

echo "Reload prefs and the Control Center process so it picks up the change immediately"
killall cfprefsd
killall ControlCenter
killall Dock

echo "Configure Finder"

#!/bin/bash

finderplist=~/Library/Preferences/com.apple.finder.plist
buddy=/usr/libexec/PlistBuddy

finderkeys=(
  "ComputerViewSettings:WindowState"
  "ICloudViewSettings:WindowState"
  "SearchViewSettings:WindowState"
  "SmartSharedSearchViewSettings:WindowState"
  "TrashViewSettings:WindowState"
)

for finderbasekey in "${finderkeys[@]}"; do
  echo "Show Status Bar for ${finderbasekey}"
  $buddy -c "Set :$finderbasekey:ShowStatusBar 1" "$finderplist" 2>/dev/null || echo "Missing: $basekey:ShowStatusBar"
  echo "Show Tab Bar for ${finderbasekey}"
  $buddy -c "Set :$finderbasekey:ShowTabView 1" "$finderplist" 2>/dev/null || echo "Missing: $basekey:ShowTabView"
  echo "Show Side Bar for ${finderbasekey}"
  $buddy -c "Set :$finderbasekey:ShowSidebar 1" "$finderplist" 2>/dev/null || echo "Missing: $basekey:ShowTabView"
  echo "Show Tool Bar for ${finderbasekey}"
  $buddy -c "Set :$finderbasekey:ShowToolbar 1" "$finderplist" 2>/dev/null || echo "Missing: $basekey:ShowTabView"
done

echo "Set default to List View"
defaults write com.apple.finder FXPreferredViewStyle Nlsv

echo "Set default sort to Kind"
defaults write com.apple.finder FXArrangeGroupViewBy Kind

echo "Show all hidden files"
defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder

killall Finder


# Paths
TARGET_DIR="$HOME/Documents"
SSH_DIR="$HOME/.ssh"
NEW_SSH_DIR="$TARGET_DIR/.ssh"

echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

# Move the real .ssh directory if it exists and isn’t already a symlink
if [ -d "$SSH_DIR" ] && [ ! -L "$SSH_DIR" ]; then
  echo "Moving $SSH_DIR to $NEW_SSH_DIR..."
  mv "$SSH_DIR" "$TARGET_DIR/"
elif [ -L "$SSH_DIR" ]; then
  echo "Detected existing symlink at $SSH_DIR; will recreate it."
else
  echo "No directory at $SSH_DIR to move; proceeding to create symlink."
fi

# Remove any existing symlink at ~/.ssh
if [ -L "$SSH_DIR" ]; then
  echo "Removing old symlink at $SSH_DIR..."
  rm "$SSH_DIR"
fi

# Create the new symlink
echo "Creating symlink: $SSH_DIR → $NEW_SSH_DIR..."
ln -s "$NEW_SSH_DIR" "$SSH_DIR"

echo "Done: moved ~/.ssh to $NEW_SSH_DIR and linked it back."