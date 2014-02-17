#!/usr/bin/env bash

# OsX settings
source ~/.init/.osx


echo " "
echo "# LANGUAGES"

echo "  * Installing rvm"
\curl -L https://get.rvm.io | bash

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

echo "  * Installing ruby"
rvm get stable
rvm reload

echo "  * Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

echo "  * Installing Brews"
brew bundle ~/.init/Brewfile

echo "  * Install global npm's"
npm config set prefix ~/npm
sudo npm install -g bower doxx generator-webapp grunt-cli jitsu jscs jshint npm-check-updates yo yeoman


echo ""
echo "# APPS"

echo "  * Install native apps"
brew cask install dropbox 2> /dev/null
brew cask install google-chrome 2> /dev/null
brew cask install google-chrome-canary 2> /dev/null
brew cask install firefox 2> /dev/null
brew cask install sublime-text 2> /dev/null
brew cask install vlc 2> /dev/null
brew cask install wunderlist 2> /dev/null
brew cask install github 2> /dev/null
brew cask install spotify 2> /dev/null
brew cask install dash 2> /dev/null
brew cask install alfred 2> /dev/null
brew cask install shiftit 2> /dev/null
brew cask install sketch 2> /dev/null
brew cask install skype 2> /dev/null
brew cask install cheatsheet 2> /dev/null

echo "  * Adove Creative Cloud"
downloadAndOpen "https://ccmdls.adobe.com/AdobeProducts/KCCC/1/osx10/CreativeCloudInstaller.dmg"

echo "  * Office"
open "https://msdn.microsoft.com/da-dk/subscriptions/securedownloads/#searchTerm=Office%20for%20Mac%202011%20Home%20and%20Business&ProductFamilyId=0&MyProducts=true&Languages=da&Architectures=mac&FileExtensions=.dmg&PageSize=10&PageIndex=0&FileId=0"

echo "  * XCode"
open "https://itunes.apple.com/us/app/xcode/id497799835"

echo "  * Color maker"
open "https://itunes.apple.com/dk/app/color-maker/id561995913"

echo "  * Download Alfred App workflows"
update alfred


echo ""
echo "# APP SETTINGS"

read -p "Install all downloaded applications and extensions. Press any key when finished. " -n 1

echo "  * Install X-Code CLI"
xcode-select --install

echo "  * subl cli"
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl

echo "  * Sublime Text 3 - Package Control"
(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package%20Control.sublime-package"
)

echo "  * Sublime Text 3 Sync"
(
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    git clone git@github.com:jvdamgaard/st3-sync.git ~/Repos/st3-sync
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)

read -p "Setup has finished. Your computer needs to be restarted before all changes will take effect. Press any key to restart. " -n 1
sudo shutdown -r now
