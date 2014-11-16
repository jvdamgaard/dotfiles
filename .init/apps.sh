# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# SASS
gem install sass

# Core
brew install coreutils
brew install findutils
brew install bash
brew install lftp

# Install wget with IRI support
brew install wget --with-iri

# Services
brew install git
brew install imagemagick
brew install graphicsmagick
brew install siege
brew install dockutil
brew install redis
brew install go

# MongoDB
brew install mongodb
sudo mkdir -p /data/db
sudo mkdir -p /data/log
sudo chown jakob /data
sudo chown jakob /data/db
sudo chown jakob /data/log

# Node
brew install node
npm config set prefix ~/npm
npm install -g azure-cli bower generator-webapp grunt-cli gulp jscs jshint nodemon npm-check-updates yo node-inspector

# Install caskroom
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Dropbox
brew cask install dropbox
open "/Applications/Dropbox.app" # Sign in
osascript -e 'display notification "Sign in with jakob_damgaard@hotmail.com" with title "Dropbox"'

# xQuartz
brew cask install xquartz

# Fireworks
brew cask install adobe-creative-cloud
open "/opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"
osascript -e 'display notification "Install" with title "Fireworks"'

# Sublime Text 3
brew cask install sublime-text3
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl
subl # Open sublime text
# Package manager
sleep 5
(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package Control.sublime-package"
)
# Sync
(
    git clone https://github.com/jvdamgaard/st3-sync.git ~/Repos/st3-sync
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)

# Atom
brew cask install atom
atom
sleep 5
# Atom Sync
(
    git clone https://github.com/jvdamgaard/atom-sync.git ~/Repos/atom-sync
    rm -r ~/.atom
    ln -s ~/Repos/atom-sync ~/.atom
)

# Office
echo "Downloading Office 2011"
download https://dl.dropboxusercontent.com/u/53998893/programmer/da_no_office_for_mac_home_and_business_2011_mac_4114798.dmg
open ~/Downloads/da_no_office_for_mac_home_and_business_2011_mac_4114798.dmg

# Google Chrome
brew cask install google-chrome
open "/Applications/Google Chrome.app" # Sign in
osascript -e 'display notification "Sign in" with title "Google Chrome"'

# Google Chrome Canary
brew cask install google-chrome-canary
open "/Applications/Google Chrome Canary.app" # Sign in
osascript -e 'display notification "Sign in" with title "Google Chrome Canary"'

# Spotify
brew cask install spotify
open "/Applications/Spotify.app" # Sign in
osascript -e 'display notification "Sign in" with title "Spotify"'

# GitHub
brew cask install github
open "/Applications/GitHub.app" # Sign in
osascript -e 'display notification "Sign in" with title "GitHub"'

# Slate
brew cask install slate
open "/Applications/Slate.app"
# TODO: what should be done with slate?

# Seil
brew cask install seil
source ~/Repos/dotfiles/.init/seil-import.sh
open "/Applications/Seil.app"
# TODO: Should the user do anything with seil?

# Karabiner
brew cask install karabiner
cp ~/Repos/dotfiles/.init/private.xml ~/Library/Application\ Support/Karabiner -f
open "/Applications/Karabiner.app"
osascript -e 'display notification "Check `Remap caps lock to hyper`" with title "Karabiner"'

# Alfred
brew cask install alfred
open "/Applications/Alfred 2.app"
sleep 2
cask alfred link
update alfred
osascript -e 'display notification "Sync with DropBox" with title "Alfred"'
osascript -e 'display notification "Install alfred workflows" with title "Alfred"'

# Dash
brew cask install dash

# iTerm2
brew cask install iterm2

# Cheat Sheet
brew cask install cheatsheet
open "/Applications/CheatSheet.app" # Activate at login

# HipChat
brew cask install hipchat
open "/Applications/HipChat.app" # Sign in
osascript -e 'display notification "Sign in with jakob.viskum.damgaard@gmail.com" with title "HipChat"'

# Skype
brew cask install skype
open "/Applications/Skype.app" # Sign in
osascript -e 'display notification "Sign in with jvd.its@dsg.dk" with title "Skype"'

# uTorrent
brew cask install utorrent
open /opt/homebrew-cask/Caskroom/utorrent/latest/uTorrent-Installer.app

# 1password
brew cask install onepassword
open "/Applications/1Password 5.app"
osascript -e 'display notification "Sync with DropBox" with title "1Password"'

# Other apps
brew cask install firefox
brew cask install vlc
brew cask install fontprep
brew cask install filezilla

# Quick look plugins
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webp-quicklook

# Remove outdated versions from the cellar
brew cleanup

# License software
azure account import ~/Dropbox/Dokumenter/Licenser/azure.publishsettings

open "/Applications/Adobe Fireworks CS6/Adobe Fireworks CS6.app"
open ~/Dropbox/Dokumenter/Licenser/fireworks.txt

open "/Applications/Microsoft Office 2011/Microsoft Word.app"
open ~/Dropbox/Dokumenter/Licenser/office2011.txt

open "/Applications/Alfred 2.app"
open ~/Dropbox/Dokumenter/Licenser/alfred.txt

open "/Applications/Dash.app"
open ~/Dropbox/Dokumenter/Licenser/dash.txt
