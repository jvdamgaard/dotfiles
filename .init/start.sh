#!/usr/bin/env bash

# OsX settings
source ~/.init/.osx


echo " "
echo "# LANGUAGES"

echo "  * Installing rvm and ruby"
\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "  * Removing MacPorts"
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

echo "  * Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

echo "  * Installing Brews"
brew bundle ~/.init/Brewfile

echo "  * Install global npm's"
npm config set prefix ~/npm
sudo npm install -g azure-cli bower doxx generator-webapp grunt-cli gulp jitsu jscs jshint npm-check-updates yo node-inspector

azure account import "Visual Studio Premium med MSDN-7-22-2014-credentials.publishsettings"

echo ""
echo "# APPS"

echo "  * Install native apps"
brew cask install dropbox 2> /dev/null
brew cask install google-chrome 2> /dev/null
brew cask install google-chrome-canary 2> /dev/null
brew cask install firefox 2> /dev/null
brew cask install vlc 2> /dev/null
brew cask install github 2> /dev/null
brew cask install spotify 2> /dev/null
brew cask install dash 2> /dev/null
brew cask install alfred 2> /dev/null
brew cask install shiftit 2> /dev/null
brew cask install skype 2> /dev/null
brew cask install cheatsheet 2> /dev/null
brew cask install fontprep 2> /dev/null
brew cask install sublime-text3 2> /dev/null
brew cask install utorrent 2> /dev/null
brew cask install filezilla 2> /dev/null
brew cask install hipchat 2> /dev/null
brew cask install atom 2> /dev/null
brew cask install parallels 2> /dev/null
brew cask install adobe-creative-cloud 2> /dev/null

# Quick look plugins
brew cask install qlcolorcode 2> /dev/null
brew cask install qlstephen 2> /dev/null
brew cask install qlmarkdown 2> /dev/null
brew cask install quicklook-json 2> /dev/null
brew cask install quicklook-csv 2> /dev/null
brew cask install betterzipql 2> /dev/null
brew cask install webp-quicklook 2> /dev/null

downloadAndOpen "http://xquartz-dl.macosforge.org/SL/XQuartz-2.7.5.dmg"

open "/Applications/Alfred 2.app"
open "/Applications/CheatSheet.app"
open "/Applications/Dash.app"
open "/Applications/Dropbox.app"
open "/Applications/GitHub.app"
open "/Applications/Google Chrome.app"
open "/Applications/Dash.app"
open "/Applications/Skype.app"
open "/Applications/Spotify.app"

# "  * Sublime Text 3"
# downloadAndOpen "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg"

echo "  * Office"
open "https://msdn.microsoft.com/da-dk/subscriptions/securedownloads/#searchTerm=Office%20for%20Mac%202011%20Home%20and%20Business&ProductFamilyId=0&MyProducts=true&Languages=da&Architectures=mac&FileExtensions=.dmg&PageSize=10&PageIndex=0&FileId=0"

echo "  * App Store Apps"
open "/Applications/App Store.app"

echo "  * Download Alfred App workflows"
update alfred


echo ""
echo "# APP SETTINGS"

read -p "Install all downloaded applications and extensions. Press any key when finished. " -n 1

echo "Link brew casks to Alfred"
brew cask alfred link

echo "  * Install X-Code CLI"
xcode-select --install

open "/Applications/Color Maker.app"
open "/Applications/ShiftIt.app"

echo "  * subl cli"
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl
subl

echo "  * Sublime Text 3 - Package Control"
(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package Control.sublime-package"
)

echo "  * Sublime Text 3 Sync"
(
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    git clone git@github.com:jvdamgaard/st3-sync.git ~/Repos/st3-sync
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)

echo "  * Atom Sync"
(
    rm -r ~/.atom
    git clone git@github.com:jvdamgaard/atom-sync.git ~/Repos/atom-sync
    ln -s ~/Repos/atom-sync ~/.atom
)

read -p "Setup has finished. Your computer needs to be restarted before all changes will take effect. Press any key to restart. " -n 1
sudo shutdown -r now
