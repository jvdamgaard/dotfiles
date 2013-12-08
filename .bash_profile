export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH
export EDITOR='subl -w'

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

# Grunt shotcuts
alias gs='grunt server'
alias gb='grunt build --force'
alias gt='grunt test'
alias gd='grunt docs'

# Node shotcuts
function id() {
	npm install
	bower install
}
function na() {
    local path="${1:-}"
	sleep 1 && open "http://localhost:8000/${path}" &
	node app
}

# programs
alias st='open -a "Sublime Text"'
alias stf='open -a "Sublime Text" .'

# git
function gitReset() {
	git reset --hard
	git clean -f -d -x
}

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

# update alle systems for web development
function update() {
	local t="${1:-help}"

	# Update home brew
	if [ ${t} == "help" ]; then
		echo " "
		echo "------------------------------------------------------------------"
		echo "Update params:"
		echo " - all             : Update all"
		echo " - brew / homebrew : update all brews"
		echo " - ruby            : update ruby and gems"
		echo " - gems / gem      : update all ruby gems"
		echo " - node            : update node and all npm's"
		echo " - npm             : update all global node packages"
		echo " - dot / dotfiles  : update dot files"
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
	if [ ${t} == "node" ] || [ ${t} == "npm" ]; then
		echo "Updating node"
		nvm install 0.10
		nvm alias default 0.10
	fi

	# Update npm packages
	if [ ${t} == "npm" ] || [ ${t} == "all" ]; then
		echo "Updating npm"
		npm update npm -g
		echo "Updating all global npm packages"
		npm -g update
	fi

	# Update dot files
	if [ ${t} == "dot" ] || [ ${t} == "dotfiles" ] || [ ${t} == "all" ]; then
		(
		    cd ~/Repos/dotfiles/
		    source bootstrap.sh --force
		)
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
			echo "Installing Nodejs"
			# brew install node
			curl https://raw.github.com/creationix/nvm/master/install.sh | sh

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

		    echo "Downloading Font Prep"
		    download "http://cdn.bitbucket.org/briangonzalez/fontprep-build/downloads/FontPrep_3.0.3.dmg"

		    echo "Downloading FontForge dependencies"
		    download "http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.4.dmg"
		    download "http://fuuko.libferris.com/osx/packages/201310/05_0907/FontForge.app.zip"

		    echo "Downloading ImageOptim"
		    download "http://imageoptim.com/ImageOptim.tbz2"

		    echo "Downloading spotify"
		    download "http://download.spotify.com/SpotifyInstaller.zip"

		    echo "Downloading VLC"
		    open "http://get.videolan.org/vlc/2.1.0/macosx/vlc-2.1.0.dmg"

		    echo "Downloading Dash"
		    download "http://kapeli.com/Dash.zip"

		    echo "Downloading Alfred App"
		    download "http://cachefly.alfredapp.com/Alfred_2.1_218.zip"

		    echo "Downloading Alfred App workflows"
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/sublime-text/sublime-text.alfredworkflow" # sublime text
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/package-managers/package-managers.alfredworkflow" # package managers
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/caniuse/caniuse.alfredworkflow" # can i use
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/colors/colors.alfredworkflow" # colors
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/dash/dash.alfredworkflow" # dash
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/github/github.alfredworkflow" # github
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/stack-overflow/stack-overflow.alfredworkflow" # stack overflow
		    download "https://raw.github.com/ruedap/alfred2-font-awesome-workflow/master/Font%20Awesome.alfredworkflow" # font-awesome
		    download "https://raw.github.com/sebietter/Wunderlist-2-for-Alfred/master/Wunderlist%202.alfredworkflow" # wunderlist
		    download "https://www.dropbox.com/s/wy8f22acqk5jf3l/Launch%20apps%20for%20web%20development.alfredworkflow" # launch web app by jakob viskum damgaard
		    download "https://raw.github.com/dingyi/Alfred-Workflows/master/Domainr/Domainr.alfredworkflow" # domainr
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/encode-decode/encode-decode.alfredworkflow" # encode/decode
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/ip-address/ip-address.alfredworkflow" #ip lookup
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/kill-process/kill-process.alfredworkflow" # kill process
		    download "https://raw.github.com/zenorocha/alfred-workflows/master/ios-simulator/ios-simulator.alfredworkflow" # ios simulator
		    download "https://raw.github.com/untoldwind/alfred2-layout/master/Layout.alfredworkflow" # layout


		    echo "Downloading ShiftIt"
		    download "https://github.com/downloads/fikovnik/ShiftIt/ShiftIt-develop-1.6.zip"

		    echo "Downloading Stay"
		    download "http://cordlessdog.com/stay/versions/Stay%201.2.3.zip"

		    echo "Downloading DashLane"
		    download "https://d3mfqat9ni8wb5.cloudfront.net/releases/2.2.5/2.2.5.48458/Dashlane.dmg"

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

	    # Ruby gems
	    	gem update --system
	    	echo "Installing compass"
	    	gem install compass

	    # HomeBrew
	    	echo "Installing HomeBrew"
	    	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
	    	brew update

	    # Mongo B
	    	echo "Installing MongoDB"
	    	brew install mongodb

	    # PhantomJS
	    	echo "Installing PhantomJS"
	    	brew install phantomjs

	    # ImageMagick
	    	echo "Installing ImageMagick"
	    	brew install ImageMagick

	    # Node with nvm
	    	nvm install 0.10
	    	nvm alias default 0.10

	    # NPM packages
	    	echo "Installing globale node.js packages"
	        echo " - Yeoman"
	        npm install -g yo
	        npm install -g generator-webapp
	        npm install -g generator-ember
	        npm install -g jitsu

	    # Font Forge
		    echo "Installing FontForge"
		    brew install fontforge

		# Sublime Text symlink
			echo "Sync Sublime Text 3 settings from DropBox"
			rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

			ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Packages/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
			ln -s ~/Dropbox/appsync/Sublime\ Text\ 3/Projects ~/Library/Application\ Support/Sublime\ Text\ 3/Projects

			echo "subl cli"
			ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

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