# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Karabiner settings
sudo cp -f ~/Repos/dotfiles/.init/private.xml ~/Library/Application\ Support/Karabiner/

source ~/Repos/dotfiles/.init/seil-import.sh

# Azure settings
# azure account import ~/Dropbox/Dokumenter/Licenser/azure.publishsettings

# Install global npm packages
update npm

# Remove outdated versions from the cellar
brew cleanup
