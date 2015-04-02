#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo ""
echo "# GENERAL UI/UX"

echo "  * Mute the sound effects on boot"
# mute on log out
sudo chmod u+x ~/.bash/mute-on.sh
sudo defaults write com.apple.loginwindow LogoutHook ~/.bash/mute-on.sh
sudo nvram SystemAudioVolume=%80
# mute on log in
# sudo chmod u+x ~/.bash/mute-off.sh
# sudo defaults write com.apple.loginwindow LoginHook ~/.bash/mute-off.sh

echo "  * Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons"
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"

echo "  * Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false


echo " "
echo "# SSD SPECIFIC TWEAKS"

echo "  * Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0


echo " "
echo "# KEYBOARD"

echo "  * Disable the caps lock key on the internal keyboard"
defaults write 'com.apple.keyboard.modifiermapping.1452-566-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'

echo "  * Disable the caps lock key on external keyboards"
defaults write 'com.apple.keyboard.modifiermapping.1452-544-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'


echo ""
echo "# TRACKPAD"

echo "  * Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "  * Trackpad: Map bottom right Trackpad corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

echo "  * Mouse: Secondary click"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton


echo ""
echo "# FINDER"

echo "  * Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  * Use list view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "  * Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  * Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  * Allow text selection in the Quick Look window"
defaults write com.apple.finder QLEnableTextSelection -bool true


echo ""
echo "# DOCK"

echo "  * Set the icon size of Dock items to 36 pixels"
defaults write com.apple.dock tilesize -int 36

echo "  * Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false


echo ""
echo "# HOT CORNERS"

echo "  * Bottom right screen corner → Desktop"
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

echo "  * Top right screen corner → Mission Control"
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0


echo ""
echo "# SAFARI"

echo "  * Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo ""
echo "# EMAL.APP"

echo "  * Copy email addresses as foo@example.com instead of Foo Bar <foo@example.com> in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "  * Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


echo ""
echo "# TERMINAL"

echo "  * Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

echo "  * Use Tomorrow Nigth theme by default in Terminal.app"
#open "${HOME}/.init/Tomorrow Night.terminal"
#sleep 1 # Wait a bit to make sure the theme is loaded
#defaults write com.apple.terminal "Default Window Settings" -string "Jakob"
#defaults write com.apple.terminal "Startup Window Settings" -string "Jakob"


echo ""
echo "# TIME MACHINE"

echo "  * Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "  * Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal

for app in "Dock" "Finder" "Mail" "Safari"; do
    killall "${app}" > /dev/null 2>&1
done

update dock