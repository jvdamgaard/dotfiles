# Install caskroom
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install xquartz

# Native apps

brew cask install alfred
open "/Applications/Alfred 2.app"
sleep 10
cask alfred link

brew cask install dropbox
open "/Applications/Dropbox.app" # Sign in

brew cask install adobe-creative-cloud
open "/opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"

brew cask install sublime-text3
# subl cli
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl

# Sublime Text 3 - Package Control
subl
sleep 10
(
    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
    curl -O -# "https://sublime.wbond.net/Package Control.sublime-package"
)

# Sublime Text 3 Sync
(
    git clone https://github.com/jvdamgaard/st3-sync.git ~/Repos/st3-sync
    rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
)

brew cask install atom
# Atom Sync
atom
sleep 10
(
    git clone https://github.com/jvdamgaard/atom-sync.git ~/Repos/atom-sync
    rm -r ~/.atom
    ln -s ~/Repos/atom-sync ~/.atom
)

brew cask install google-chrome
open "/Applications/Google Chrome.app" # Sign in

brew cask install google-chrome-canary
open "/Applications/Google Chrome Canary.app" # Sign in

brew cask install spotify
open "/Applications/Spotify.app" # Sign in

brew cask install github
open "/Applications/GitHub.app" # Sign in

brew cask install slate
open "/Applications/Slate.app"
# TODO: what should be done with slate?

brew cask install seil
open "/Applications/Seil.app"
# TODO: what should be done with seil?

brew cask install karabiner
open "/Applications/Karabiner.app"
# TODO: what should be done with karabiner?

brew cask install dash
open "/Applications/Dash.app"
# TODO: open license txt

brew cask install iterm2
# TODO: Copy iTerm settings
#
brew cask install cheatsheet
open "/Applications/CheatSheet.app" # Activate at login

brew cask install hipchat
open "/Applications/HipChat.app" # Sign in

brew cask install skype
open "/Applications/Skype.app" # Sign in

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
