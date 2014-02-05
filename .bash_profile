export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/sbin:~/npm/bin:$PATH
export EDITOR='subl -w'

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

# git
function gitReset() {
	git reset --hard
	git clean -f -d -x
}

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

# Grunt shortcut
function g() {
    grunt $@
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

# update alle systems for web development
function update() {
	local t="${1:-help}"

	# Update home brew
	if [ ${t} == "help" ]; then
		echo " "
		echo "------------------------------------------------------------------"
		echo "Update params:"
		echo " - all             : Update all"
        echo " - alfred          : Downlaod all Alfred 2 workflows for update"
        echo " - dot / dotfiles  : update dot files"
		echo " - brew / homebrew : update all brews"
		echo " - gems / gem      : update all ruby gems"
		echo " - node            : update node and all global npm's"
		echo " - npm             : update all global node packages"
        echo " - ruby            : update ruby and gems"
		echo "------------------------------------------------------------------"
		echo " "
	fi

	# Update home brew
	if [ ${t} == "brew" ] || [ ${t} == "homebrew" ] || [ ${t} == "all" ]; then
		echo "Updating brew"
		brew update
		echo "Updating all brew packages"
		brew upgrade
	fi

	# Update ruby
	if [ ${t} == "ruby" ] || [ ${t} == "all" ]; then
		echo "Updating ruby"
		rvm get stable
		rvm reload
	fi

	# Update ruby gems
	if [ ${t} == "ruby" ] || [ ${t} == "gems" ] || [ ${t} == "gem" ] || [ ${t} == "all" ]; then
		echo "Updating gems"
		gem update --system
		gem update
	fi

	# Update node
	if [ ${t} == "node" ] || [ ${t} == "all" ]; then
		echo "Updating node"
		n stable
        npm config set prefix ~/npm
	fi

	# Update npm packages
	if [ ${t} == "npm" ] || [ ${t} == "node" ] || [ ${t} == "all" ]; then
		echo "Updating npm"
		sudo npm install npm -g
		echo "Updating all global npm packages"
		sudo npm install -g bower doxx generator-webapp grunt-cli jitsu jscs jshint n npm-check-updates yo
	fi

	# Update dot files
	if [ ${t} == "dot" ] || [ ${t} == "dotfiles" ] || [ ${t} == "all" ]; then
		(
		    cd ~/Repos/dotfiles/
		    source bootstrap.sh --force
		)
	fi

    # Download alfred workflows
    if [ ${t} == "alfred" ] || [ ${t} == "all" ]; then
        echo "Downloading Alfred 2 workflows"

        echo "Sublime Text"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/sublime-text/sublime-text.alfredworkflow" # sublime text

        echo "Package Manager"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/package-managers/package-managers.alfredworkflow" # package managers

        echo "Can I Use"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/caniuse/caniuse.alfredworkflow" # can i use

        echo "Colors"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/colors/colors.alfredworkflow" # colors

        echo "Dash"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/dash/dash.alfredworkflow" # dash

        echo "Github"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/github/github.alfredworkflow" # github

        echo "Font-Awesome"
        download "https://raw.github.com/ruedap/alfred2-font-awesome-workflow/master/Font%20Awesome.alfredworkflow" # font-awesome

        echo "Wunderlist"
        download "https://raw.github.com/sebietter/Wunderlist-2-for-Alfred/master/Wunderlist%202.alfredworkflow" # wunderlist

        echo "Domainr"
        download "https://raw.github.com/dingyi/Alfred-Workflows/master/Domainr/Domainr.alfredworkflow" # domainr

        echo "Encode/Decode"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/encode-decode/encode-decode.alfredworkflow" # encode/decode

        echo "IP Address"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/ip-address/ip-address.alfredworkflow" #ip lookup

        echo "Kill Process"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/kill-process/kill-process.alfredworkflow" # kill process

        echo "iOs Simuator"
        download "https://raw.github.com/zenorocha/alfred-workflows/master/ios-simulator/ios-simulator.alfredworkflow" # ios simulator

        echo "Layout"
        download "https://raw.github.com/untoldwind/alfred2-layout/master/Layout.alfredworkflow" # layout

        echo "ALmost white theme"
        download "http://f.cl.ly/items/352h1L0J3a0r2s2P3V2F/Almost%20white%20v2.1.alfredappearance"

        echo "Google Translate"
        download "https://raw.github.com/thomashempel/AlfredGoogleTranslateWorkflow/master/GoogleTranslate.alfredworkflow"

        echo "TinyPNG"
        download "https://dl.dropboxusercontent.com/u/2377432/alfredv2/tinypng/TinyPNG.alfredworkflow"

        echo "Alleyoop"
        download "https://raw.github.com/phyllisstein/Workflows/master/Alleyoop%203/Alleyoop.alfredworkflow"

        echo "Search Chrome Bookmarks"
        download "https://raw.github.com/mdreizin/alfred-workflows/master/chrome-bookmarks/zip/chrome-bookmarks.alfredworkflow"
    fi
}

# Install all services and programs from scratch
function init() {
	step="${1:-help}"

	# Step 1
	if [ ${step} == "step1" ]; then

		# Ruby
			echo "Installing rvm"
			\curl -L https://get.rvm.io | bash

		# Remove MacPorts
			echo "Removing MacPorts"
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

		# NodeJS
			echo "Download Node.js"
			download "http://nodejs.org/dist/v0.10.25/node-v0.10.25.pkg"

		# Download programs
			echo "Downloading Sublime Text"
		    download "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203047.dmg"

		    echo "Downloading Browsers"
		    download "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
		    download "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
		    download "http://download-installer.cdn.mozilla.net/pub/mozilla.org/firefox/releases/24.0/mac/da/Firefox%2024.0.dmg"

		    echo "Downloading GitHub Client"
		    download "https://github-central.s3.amazonaws.com/mac/GitHub%20for%20Mac%20162.zip"

		    echo "Downloading Fireworks"
		    download "https://ccmdls.adobe.com/AdobeProducts/FWKS/12/osx10/AAMmetadataLS16/CreativeCloudInstaller.dmg"

		    echo "Downloading DropBox"
		    download "https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.0.26.dmg"

		    echo "Downloading spotify"
		    download "http://download.spotify.com/SpotifyInstaller.zip"

		    echo "Downloading VLC"
		    open "http://get.videolan.org/vlc/2.1.0/macosx/vlc-2.1.0.dmg"

		    echo "Downloading Dash"
		    download "http://kapeli.com/Dash.zip"

		    echo "Downloading Alfred App"
		    download "http://cachefly.alfredapp.com/Alfred_2.1_218.zip"

		    echo "Downloading Alfred App workflows"
		    update alfred

		    echo "Downloading ShiftIt"
		    download "https://github.com/downloads/fikovnik/ShiftIt/ShiftIt-develop-1.6.zip"

		    open "~/Downloads/"

		# Open webpages for download of programs
		    echo "App Store - Wunderlist"
		    open "https://www.wunderlist.com/"

		    echo "App Store - XCode"
		    open "https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12"

		    echo "Office"
		    open "https://msdn.microsoft.com/da-dk/subscriptions/securedownloads/#searchTerm=Office%20for%20Mac%202011%20Home%20and%20Business&ProductFamilyId=0&MyProducts=true&Languages=da&Architectures=mac&FileExtensions=.dmg&PageSize=10&PageIndex=0&FileId=0"

		# Step 1 finished
			echo " "
			echo "------------------------------------------------------------------"
			echo "Install programs. Restart terminal and run command ‘init step2’"
			echo "------------------------------------------------------------------"
			echo " "
			say "Step 1 finished. Install programs and restart terminal"

	# Step 2
	elif [ ${step} == "step2" ]; then

		# XCode command-line tools
			echo "Xode cli"
			xcode-select --install

	    # Ruby with rvm
	    	echo "Installing ruby"
	    	rvm get stable
	    	rvm reload
	    	rvm install 2.0.0

	    # HomeBrew
	    	echo "Installing HomeBrew"
	    	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
	    	brew update

	    # Node and npm packages
	    	update node

        # Sublime as a command line tool
			echo "subl cli"
			ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

        # Sync sublime settings
            echo "Sublime Text 3 Sync"
            (
                rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
        		git clone git@github.com:jvdamgaard/st3-sync.git ~/Repos/st3-sync
        		ln -s ~/Repos/st3-sync ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
            )
            open "https://sublime.wbond.net/installation"

	    # Step 2 finished
	    	echo " "
		    echo "------------------------------------------------------------------"
		    echo "Done"
		    echo "------------------------------------------------------------------"
		    echo " "
		    say "Done"

	# Help
	else
		echo " "
		echo "------------------------------------------------------------------"
		echo "Init mac by installing all programs"
		echo " 1. Run command ´init step1´"
		echo " 2. Install all downloaded programs"
		echo " 3. Restart terminal"
		echo " 4. Run command ´init step2"
		echo "------------------------------------------------------------------"
		echo " "
	fi
}
