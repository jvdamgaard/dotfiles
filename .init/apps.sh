# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Casks
brew cask install dropbox && open "/Applications/Dropbox.app" # Sign in
brew cask install 1password && open "/Applications/1Password 6.app"
# brew cask install xquartz
# brew cask install adobe-creative-cloud
# brew cask install axure-rp-pro
brew cask install sketch && open "/Applications/Sketch.app"
brew cask install sketch-toolbox && open "/Applications/Sketch Toolbox.app"
brew cask install zeplin
brew cask install sublime-text3
# brew cask install atom
brew cask install google-chrome && open "/Applications/Google Chrome.app"
brew cask install google-chrome-canary && open "/Applications/Google Chrome Canary.app"
brew cask install spotify
brew cask install github-desktop
brew cask install mattr-slate && open "/Applications/Slate.app"
brew cask install seil && open "/Applications/Seil.app"
brew cask install karabiner && open "/Applications/Karabiner.app"
brew cask install alfred
brew cask install dash
brew cask install cheatsheet
# brew cask install hipchat
# brew cask install unsplash-wallpaper
# brew cask install lync
# brew cask install skype
brew cask install utorrent
brew cask install firefox
brew cask install vlc
brew cask install slack && open "/Applications/Slack.app"
# brew cask install fontprep
# brew cask install filezilla
# brew cask install xmarks-safari # Sync bookmarks to safari. Used for Alfred search
# brew cask install sketchup
# open https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417

open "https://support.office.com/en-us/article/Download-and-install-or-reinstall-Office-2016-for-Mac-299c3f95-3551-4e60-a9cf-7380457d8e37"
open "https://itunes.apple.com/us/app/irvue-unsplash-wallpapers/id1039633667?mt=12"
open "https://www.flinto.com/mac/download"
