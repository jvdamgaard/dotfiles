#!/usr/bin/env bash
#
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install ruby
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install git
brew install git

# Clone dotfiles
git clone https://github.com/jvdamgaard/dotfiles.git ~/Repos/dotfiles

# Install dotfiles
source ~/Repos/dotfiles/bootstrap.sh --force

# Install applications and settings
source ~/Repos/dotfiles/.init/apps.sh

# OSX settings
source ~/Repos/dotfiles/.init/osx.sh

# Open docs
open https://github.com/jvdamgaard/dotfiles/blob/master/docs/fresh-install-guide.md

open "/Applications/Karabiner.app"
open "/Applications/Alfred Preferences.app"
open "/Applications/Dash.app"
open "/Applications/System Preferences.app"
