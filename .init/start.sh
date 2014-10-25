#!/usr/bin/env bash

# OsX settings
source ~/.init/.osx


echo " "
echo "# LANGUAGES"

echo "  * Install X-Code CLI"
xcode-select --install

echo "  * Installing rvm and ruby"
\curl -sSL https://get.rvm.io | bash -s stable --ruby

reload

echo "  * Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

echo "  * Installing SASS"
sudo gem install sass

echo "  * Installing Brews"
source ~/.init/Brewfile.sh

echo "  * Install global npm's"
update npm

echo ""
echo "# APPS"

echo "  * Installing Casks"
source ~/.init/Caskfile.sh

echo "  * Office"
open "https://msdn.microsoft.com/da-dk/subscriptions/securedownloads/#searchTerm=Office%20for%20Mac%202011%20Home%20and%20Business&ProductFamilyId=0&MyProducts=true&Languages=da&Architectures=mac&FileExtensions=.dmg&PageSize=10&PageIndex=0&FileId=0"

say "Install all downloaded applications and extensions."
read -p "Install all downloaded applications and extensions. Press any key when finished. " -n 1


echo ""
echo "# APP SETTINGS"

echo "  * Set up Azure CLI"
azure account import "~/Dropbox/Dokumenter/Licenser/Visual Studio Premium med MSDN-7-22-2014-credentials.publishsettings"

echo "  * Download Alfred App workflows"
open "~/Dropbox/Dokumenter/Licenser/mac.rtf"
update alfred

echo "  * subl cli"
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl

echo "  * Sublime Text 3 - Package Control"
subl
sleep 10
(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package Control.sublime-package"
)

echo "  * Sublime Text 3 Sync"
(
    git clone https://github.com/jvdamgaard/st3-sync.git ~/Repos/st3-sync
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)

echo "  * Atom Sync"
atom
sleep 10
(
    git clone https://github.com/jvdamgaard/atom-sync.git ~/Repos/atom-sync
    rm -r ~/.atom
    ln -s ~/Repos/atom-sync ~/.atom
)

echo "  * Set Dock layout"
update dock

echo "  * Import seil setup"
sh ~/.init/seil-import.sh

echo "  * Manuel steps"
open ~/Repos/dotfiles/.init/manuel-things-to-remember.txt

read -p "Setup has finished. Your computer needs to be restarted before all changes will take effect. Press any key to restart. " -n 1
sudo shutdown -r now
