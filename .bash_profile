export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR='subl -w'

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

. ~/.bash/z.sh

# Show/hide hidden files
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Easier navigation: ., .., ..., ...., .....
alias .="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -l ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# programs
alias st='open -a "Sublime Text"'
alias stf='open -a "Sublime Text" .'

function stp() {
    local project=${PWD##*/}
    subl --project ${project}.sublime-project
}

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Download file
function download() {
    ( 
    	cd ~/Downloads/ 
    	curl -O -# $1
    ) 
}

#Add spacer to dock
function dockSpacer() {
    defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
    killall Dock
} 

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@"
    }
fi

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
        MAGENTA=$(tput setaf 9)
        ORANGE=$(tput setaf 172)
        GREEN=$(tput setaf 190)
        PURPLE=$(tput setaf 141)
        WHITE=$(tput setaf 0)
    else
        MAGENTA=$(tput setaf 5)
        ORANGE=$(tput setaf 4)
        GREEN=$(tput setaf 2)
        PURPLE=$(tput setaf 1)
        WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch in prompt.
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

export PS1="\[$RESET\]\$ \[$MAGENTA\]\w/ \$([[ -n \$(git branch 2> /dev/null) ]] && echo \"\")\[$GREEN\]\$(parse_git_branch)\[$RESET\]"


# update node
function updateNode() {

    # latest node 0.10 version
    echo "Updating node.js"
    nvm install 0.10
    nvm alias default 0.10

    # update npm
    echo "Updating npm"
    curl https://npmjs.org/install.sh | sh

    # update all global node packages
    echo "Updating all global npm packages"
    npm -g update

}

# update homebrew
function updateBrew() {
    echo "Updating brew"
    brew update

    echo "Updating all brew packages"
    brew upgrade
}

# update ruby
function updateRuby() {

    # update ruby
    echo "Updating ruby"
    rvm get stable
    rvm reload
    gem update --system

    # gems
    echo "Updating gems"
    gem update

}

# update dot files
function updateDotFiles() {
    (
        cd ~/Repos/dotfiles/
        source bootstrap.sh
    )
}

# update alle systems for web development
function updateAll() {

    updateNode
    updateBrew
    updateRuby
    updateDotFiles
}

function initNode() {

    # node version manager
    echo "Installing node.js"
    curl https://raw.github.com/creationix/nvm/master/install.sh | sh

    # latest node.js
    echo "Getting latest stable node.js version"
    nvm install 0.10
    nvm alias default 0.10

    # npm
    echo "Latest npm"
    curl https://npmjs.org/install.sh | sh

    # yeoman
    echo "Installing globale node.js packages"
    echo " - Yeoman"
    npm install -g yo
    npm install -g generator-webapp
    npm install -g generator-ember
    echo " - Node Jitsu"
    npm install -g jitsu

}

function initRuby() {

    # rvm
    echo "Installing rvm"
    \curl -L https://get.rvm.io | bash

    echo "Installing ruby"
    rvm get stable
    rvm reload
    rvm install 2.0.0
    gem update --system

    # compass
    echo "Installing compass"
    gem install compass

}

function initBrew() {

    # homebrew
    echo "Installing HomeBrew"
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    brew update

    # MongoDB
    echo "Installing MongoDB"
    brew install mongodb
}

function initPrograms() {

    # sublime text
    echo "Downloading Sublime Text"
    download http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203047.dmg

    # google chrome canary
    echo "Downloading Google Chrome Canary"
    download https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg

    # github
    echo "Downloading GitHub Client"
    download https://central.github.com/mac/latest

    # fireworks
    echo "Downloading Fireworks"
    download https://ccmdls.adobe.com/AdobeProducts/FWKS/12/osx10/AAMmetadataLS16/CreativeCloudInstaller.dmg

    # dropbox
    echo "Downloading DropBox"
    download https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.0.26.dmg

    # font prep
    echo "Downloading Font Prep"
    download http://cdn.bitbucket.org/briangonzalez/fontprep-build/downloads/FontPrep_3.0.3.dmg

    open ~/Downloads/

    # xCode
    open "https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12#"

}

function initST3() {
    read -p "For making synchronization of Sublime Text 3 packages both ST3 and Dropbox must be installed. Are ST3 and Dropbox installed? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
        rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Pristine\ Packages
        rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

        ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Installed\ Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
        ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Pristine\ Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Pristine\ Packages
        ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
        ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Projects ~/Library/Application\ Support/Sublime\ Text\ 3/Projects

        # subl cli
        ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
    fi
}

# Install all services and programs from scratch
function initAll() {
    initNode
    initRuby
    initBrew
    initPrograms
    initDotFiles
    initST3
}