# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew install coreutils
brew install findutils
brew install bash

# Install wget with IRI support
brew install wget --enable-iri

brew install git
brew install node
brew install mongodb
brew install imagemagick
brew install graphicsmagick
brew install siege
brew install fontforge --with-x
brew install dockutil

# Remove outdated versions from the cellar
brew cleanup
