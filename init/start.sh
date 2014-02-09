#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "##################################"
echo "# GENERAL UI/UX"
echo "##################################"

echo "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo "Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons"
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

echo "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false


echo "##################################"
echo "# SSD_SPECIFIC TWEAKS"
echo "##################################"

echo "Disable local Time Machine snapshots"
sudo tmutil disablelocal

echo "Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0


echo "##################################"
echo "# TRACKPAD"
echo "##################################"

echo "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Trackpad: map bottom right corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true


echo "##################################"
echo "# FINDER"
echo "##################################"

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Use list view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false


echo "##################################"
echo "# DOCK"
echo "##################################"

echo "Set the icon size of Dock items to 36 pixels"
defaults write com.apple.dock tilesize -int 36

echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "# Add iOS Simulator to Launchpad"
sudo ln -sf /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app


echo "##################################"
echo "# HOT CORNERS"
echo "##################################"

echo "Bottom right screen corner → Desktop"
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
echo "Top right screen corner → Mission Control"
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0


echo "##################################"
echo "# SAFARI"
echo "##################################"

echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "##################################"
echo "# EMAL.APP"
echo "##################################"

echo "Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


echo "##################################"
echo "# TERMINAL"
echo "##################################"

echo "Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

echo "Use a modified version of the Pro theme by default in Terminal.app"
open "${HOME}/init/Monokai.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded


echo "##################################"
echo "# TIME MACHINE"
echo "##################################"

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal


echo "##################################"
echo "# LANGUAGES"
echo "##################################"

echo "Installing rvm"
\curl -L https://get.rvm.io | bash

echo "Removing MacPorts"
sudo port -fp uninstall installed
sudo rm -rf \
/opt/local \
/Applications/DarwinPorts \
/Applications/MacPorts \
/Library/LaunchDaemons/org.macports.* \
/Library/Receipts/DarwinPorts*.pkg \
/Library/Receipts/MacPorts*.pkg \
/Library/StartupItems/DarwinPortsStartup \
/Library/Tcl/darwinports1.0 \
/Library/Tcl/macports1.0 \
~/.macports

reload

echo "Installing ruby"
rvm get stable
rvm reload

echo "Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
brew update

echo "Install node.js"
brew install node
reload

echo "Install global npm's"
sudo npm install -g bower doxx generator-webapp grunt-cli jitsu jscs jshint n npm-check-updates yo


echo "##################################"
echo "# APPS"
echo "##################################"

echo "Install brews"
brew tap phinze/homebrew-cask
brew install brew-cask

echo "Install native apps"
brew cask install dropbox 2> /dev/null
brew cask install google-chrome 2> /dev/null
brew cask install google-chrome-canary 2> /dev/null
brew cask install firefox 2> /dev/null
brew cask install sublime-text 2> /dev/null
brew cask install vlc 2> /dev/null
brew cask install wunderlist 2> /dev/null
brew cask install github 2> /dev/null
brew cask install spotify 2> /dev/null
brew cask install dash 2> /dev/null
brew cask install alfred 2> /dev/null
brew cask install shifti 2> /dev/nullt

echo "Office"
open "https://msdn.microsoft.com/da-dk/subscriptions/securedownloads/#searchTerm=Office%20for%20Mac%202011%20Home%20and%20Business&ProductFamilyId=0&MyProducts=true&Languages=da&Architectures=mac&FileExtensions=.dmg&PageSize=10&PageIndex=0&FileId=0"

echo "XCode"
open "https://itunes.apple.com/us/app/xcode/id497799835"

echo "Color maker"
open "https://itunes.apple.com/dk/app/color-maker/id561995913"

echo "Download Alfred App workflows"
update alfred


echo "##################################"
echo "# APP SETTINGS"
echo "##################################"

read -p "Install all downloaded applications and extensions. Press any key when finished. " -n 1

echo "Install X-Code CLI"
xcode-select --install

echo "subl cli"
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl

(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package%20Control.sublime-package"
)

echo "Sublime Text 3 Sync"
(
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    git clone git@github.com:jvdamgaard/st3-sync.git ~/Repos/st3-sync
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)


for app in "Dock" "Finder" "Mail" "Safari" "Terminal" ; do
    killall "${app}" > /dev/null 2>&1
done