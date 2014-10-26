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

# Install wget with IRI support
brew install wget --with-iri

# Services
brew install git
brew install mongodb
brew install imagemagick
brew install graphicsmagick
brew install siege
brew install dockutil

# Node
brew install node
npm config set prefix ~/npm
npm install -g azure-cli bower generator-webapp grunt-cli gulp jscs jshint npm-check-updates yo node-inspector
osascript -e 'display notification "When Dropbox has finished sync: azure account import ~/Dropbox/Dokumenter/Licenser/azure.publishsettings" with title "Azure"'

# Install caskroom
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# xQuartz
brew cask install xquartz

# Alfred
brew cask install alfred
open "/Applications/Alfred 2.app"
sleep 10
cask alfred link
# TODO: Open link to alfred license
osascript -e 'display notification "License Alfred powerpack" with title "Alfred"'
update alfred
osascript -e 'display notification "Install alfred workflows" with title "Alfred"'

# Dropbox
brew cask install dropbox
open "/Applications/Dropbox.app" # Sign in
osascript -e 'display notification "Sign in" with title "Dropbox"'

# Fireworks
brew cask install adobe-creative-cloud
open "/opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"
osascript -e 'display notification "Install" with title "Fireworks"'
# TODO: open license for fireworks
osascript -e 'display notification "License" with title "Fireworks"'

# Sublime Text 3
brew cask install sublime-text3
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl
subl # Open sublime text
# Package manager
sleep 10
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
sleep 10
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
# TODO: Open license

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
cp ~/Repos/dotfiles/.init/private.xml ~/Library/Application\ Support/Karabiner -f # TODO: Is it working?
open "/Applications/Karabiner.app"
osascript -e 'display notification "Check `Remap caps lock to hyper`" with title "Karabiner"'

# Dash
brew cask install dash
open "/Applications/Dash.app"
# TODO: open license txt
osascript -e 'display notification "License" with title "Dash"'

# iTerm2
brew cask install iterm2
# TODO: Copy iTerm settings

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

# Other apps
brew cask install firefox
brew cask install vlc
brew cask install fontprep
brew cask install utorrent
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
