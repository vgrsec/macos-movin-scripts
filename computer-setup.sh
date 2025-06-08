#!/bin/bash
#
### VGR - Move into a New Laptop
#
### Finder Scripts 
### Changelog ###
#
# 20191228 Initial Scripts
# 20250515 Updates



# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Try: sudo $0"
  exit 1
fi

echo "Running as root..."
# Continue with the rest of the script here

###### Remove users from filevault
echo "Initial FileVault Users:"
fdesetup list

while true; do
  echo
  echo "Current FileVault Users:"
  users=($(fdesetup list | cut -d',' -f1))
  
  if [ ${#users[@]} -eq 0 ]; then
    echo "No more users to remove."
    break
  fi

  i=1
  for user in "${users[@]}"; do
    echo "$i) $user"
    ((i++))
  done
  echo "0) Exit"

  read -p "Select a user to remove by number (0 to exit): " choice

  if [[ "$choice" == "0" ]]; then
    echo "Exiting."
    break
  elif [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#users[@]} )); then
    user_to_remove="${users[$((choice-1))]}"
    echo "Removing user: $user_to_remove"
    fdesetup remove -user "$user_to_remove"
  else
    echo "Invalid choice. Please select a valid number."
  fi
done

##### Random HostName ######

echo "Setup RandomHostName"
echo "Setting up directories..."

# Setup Directories
if [ -d /usr/local/bin ]; then
  echo "/usr/local/bin already exists. Skipping directory creation."
else
  mkdir -p /usr/local/bin
  echo "Created /usr/local/bin."
fi

echo "Installing random hostname script..."

# Install randomhostname.sh
if [ -f /usr/local/bin/randomhostname.sh ]; then
  echo "/usr/local/bin/randomhostname.sh already exists. Skipping copy."
else
  cp ./randomhostname.sh /usr/local/bin/randomhostname.sh
  echo "Copied randomhostname.sh to /usr/local/bin/"
fi

# Install LaunchDaemon plist
if [ -f /Library/LaunchDaemons/com.randomhostname.plist ]; then
  echo "/Library/LaunchDaemons/com.randomhostname.plist already exists. Skipping copy."
else
  cp ./com.randomhostname.plist /Library/LaunchDaemons/com.randomhostname.plist
  echo "Copied plist to /Library/LaunchDaemons/"
fi

# Load LaunchDaemon (idempotent call)
echo "Loading LaunchDaemon..."
launchctl load -w /Library/LaunchDaemons/com.randomhostname.plist 2>/dev/null || echo "LaunchDaemon may already be loaded."


echo "Require both username and password at login"
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true
# Disable Fast User Switching 
defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false

### Prevents BruteForce
###	maxFailedLoginAttempts=5: Locks out after 5 failed tries.
###	minutesUntilFailedLoginReset=15: Unlocks after 15 minutes.

echo "Always low power mode"
pmset -a lowpowermode 1

echo "Setting login policies for all local user accounts..."

# Filter for real users (UID >= 501 and not hidden/system)
users=$(dscl . list /Users UniqueID | awk '$2 >= 501 { print $1 }')

for user in $users; do
  echo "Applying pwpolicy to user: $user"
  pwpolicy -u "$user" -setglobalpolicy "maxFailedLoginAttempts=5 minutesUntilFailedLoginReset=15"
  if [ $? -eq 0 ]; then
    echo "Policy applied to $user"
  else
    echo "Failed to apply policy to $user"
  fi
done

echo "Policy application complete."

echo "Remove Guest Account and auto login"
defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string ""
defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool true
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true
echo "Global password immediately after sleep/screensaver"

sysadminctl -screenLock immediate -password -

echo "per user screen lock settings"
#!/bin/bash
users=$(dscl . list /Users UniqueID | awk '$2 >= 501 { print $1 }')

for user in $users; do
  user_home="/Users/$user"
  [ -d "$user_home" ] || continue

  echo "Enforcing screensaver lock for user: $user"
  sudo -u "$user" HOME="$user_home" defaults write com.apple.screensaver askForPassword -int 1
  sudo -u "$user" HOME="$user_home" defaults write com.apple.screensaver askForPasswordDelay -int 0
done

echo "Screensaver settings applied for all users."

echo "Symlink Downloads to Documents folder so Downloads upload to iCloud"

for user_dir in /Users/*; do
  username=$(basename "$user_dir")

  # Skip system users
  if [[ "$username" == "Shared" || "$username" == ".localized" ]]; then
    continue
  fi

  downloads_path="$user_dir/Downloads"
  new_target="$user_dir/Documents/Downloads"

  echo "Processing user: $username"

  # Remove flags if any
  if [ -e "$downloads_path" ]; then
    chflags -R nouchg,noschg "$downloads_path" 2>/dev/null
    rm -rf "$downloads_path"
  fi

  # Ensure Documents/Downloads exists
  mkdir -p "$new_target"

  # Create the symlink
  ln -s "$new_target" "$downloads_path"

  # Set correct ownership
  chown -h "$username" "$downloads_path"               # for the symlink itself
  chmod 755 "$new_target"
  chown -R "$username:staff" "$new_target"
  echo "Linked /Users/$username/Downloads → /Users/$username/Documents/Downloads"
done