#!/usr/bin/env bash

# OsX settings
source ~/.init/.osx


echo " "
echo "# LANGUAGES"

echo "  * Install X-Code CLI"
xcode-select --install

echo "  * Installing rvm and ruby"
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# echo "  * Removing MacPorts"
# sudo port -fp uninstall installed
# sudo rm -rf \
# /opt/local \
# /Applications/DarwinPorts \
# /Applications/MacPorts \
# /Library/LaunchDaemons/org.macports.* \
# /Library/Receipts/DarwinPorts*.pkg \
# /Library/Receipts/MacPorts*.pkg \
# /Library/StartupItems/DarwinPortsStartup \
# /Library/Tcl/darwinports1.0 \
# /Library/Tcl/macports1.0 \
# ~/.macports

reload

echo "  * Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

echo "  * Installing SASS"
sudo gem install sass

echo "  * Installing Brews"
brew bundle ~/.init/Brewfile

echo "  * Install global npm's"
npm config set prefix ~/npm
sudo npm install -g azure-cli bower doxx generator-webapp grunt-cli gulp jitsu jscs jshint npm-check-updates yo node-inspector

echo ""
echo "# APPS"

echo "  * Installing Casks"
brew bundle ~/.init/Caskfile

echo "  * Open apps for settings"
open "/Applications/Alfred 2.app"
open "/Applications/CheatSheet.app"
open "/Applications/Dash.app"
open "/Applications/Dropbox.app"
open "/Applications/GitHub.app"
open "/Applications/Google Chrome.app"
open "/Applications/Google Chrome Canary.app"
open "/Applications/Skype.app"
open "/Applications/Spotify.app"
<<<<<<< HEAD
open "/Applications/Color Maker.app"
open "/Applications/Slate.app"
open "/Applications/Seil.app"
open "/Applications/Adobe Create Cloud.app"
open "/Applications/iTerm.app"
open "/Applications/App Store.app"
=======
open "/Applications/Slate.app"
open "/Applications/Adobe Create Cloud.app"
open "/Applications/Karabiner.app"
>>>>>>> FETCH_HEAD

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
