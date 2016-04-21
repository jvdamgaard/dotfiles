# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Node
brew install nvm
mkdir ~/.nvm
source $(brew --prefix nvm)/nvm.sh
nvm install 4
nvm alias default 4

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

# Install caskroom
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
