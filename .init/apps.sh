# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# SASS
sudo gem install sass
sudo gem install scss-lint

# Core
brew install coreutils
brew install findutils
brew install bash
brew install homebrew/science/vips
# brew install lftp

# Install wget with IRI support
# brew install wget --with-iri

# Services
# brew install git # already installed
# brew install imagemagick
# brew install graphicsmagick
# brew install siege
brew install dockutil
brew install redis
# brew install go
# brew install pandoc # Beautify markdown

# MongoDB
# brew install mongodb
# sudo mkdir -p /data/db
# sudo mkdir -p /data/log
# sudo chown jakob /data
# sudo chown jakob /data/db
# sudo chown jakob /data/log

# Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.10.32
nvm install stable
nvm alias default stable
update npm

# Install caskroom
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Casks
brew cask install dropbox && open "/Applications/Dropbox.app" # Sign in
brew cask install 1password
# brew cask install xquartz
# brew cask install adobe-creative-cloud
brew cask install axure-rp-pro
brew cask install sketch
brew cask install sketch-toolbox
brew cask install sublime-text3
brew cask install atom
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install spotify
brew cask install github-desktop
brew cask install mattr-slate
brew cask install seil
brew cask install karabiner
brew cask install alfred
brew cask install dash
brew cask install cheatsheet
brew cask install hipchat
brew cask install unsplash-wallpaper
# brew cask install lync
# brew cask install skype
brew cask install utorrent && open /opt/homebrew-cask/Caskroom/utorrent/latest/uTorrent.app
brew cask install firefox
brew cask install vlc
brew cask install slack
# brew cask install fontprep
brew cask install filezilla
# brew cask install xmarks-safari # Sync bookmarks to safari. Used for Alfred search
# brew cask install sketchup
# open https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417

# Quick look plugins
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webpquicklook

# Sync sublime settings
# sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl
# subl # Open sublime text
# # Package manager
# sleep 5
# (
#     cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
#     curl -O -# "https://sublime.wbond.net/Package Control.sublime-package"
# )
# # Sync
# (
#     git clone https://github.com/jvdamgaard/st3-sync.git ~/Repos/st3-sync
#     rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
#     ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
# )

# Karabiner settings
sudo cp -f ~/Repos/dotfiles/.init/private.xml ~/Library/Application\ Support/Karabiner/

# Sync atom settings
apm install sync-settings

# Seil settings
open /Applications/Seil.app
open /Applications/Karabiner.app

open /Applications/Slack.app
open /Applications/Atom.app

source ~/Repos/dotfiles/.init/seil-import.sh

# Azure settings
azure account import ~/Dropbox/Dokumenter/Licenser/azure.publishsettings

# Remove outdated versions from the cellar
brew cleanup
