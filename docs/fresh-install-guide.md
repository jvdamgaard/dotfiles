# Fresh Install Guide

## 1. Clean install OSX

[Google](https://www.google.dk/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=clean%20install%20os%20x)

## 2. Install x-code

## 3. Install dependencies

Install ruby, homebrew and git:

```bash
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install git
```

## 4. Clone dotfiles repository

```bash
$ git clone https://github.com/jvdamgaard/dotfiles.git ~/Repos/dotfiles
```

## 5. Install dotfiles

```bash
$ source ~/Repos/dotfiles/bootstrap.sh --force
```

## 6. Install utilities

```bash
$ source ~/Repos/dotfiles/.init/utils.sh
```

## 7. Install applications

```bash
$ source ~/Repos/dotfiles/.init/apps.sh
```

## 9. Update osx settings

```bash
$ source ~/Repos/dotfiles/.init/osx.sh
```

## 10. Sync settings

1password:

1. Use dropbox

Alfred:

1. Insert Powerpack license from 1Password
2. Under _Advanced_ choose _Set sync folder..._ and select `~/Dropbox/dokumenter/alfred-sync`

Sublime Text:

1. [Install Package Control](https://packagecontrol.io/installation)
2. Open Package Control and download Sync Settings
3. Open Sync Settings on "Sublime Text" > "Preferences" > "Package Settings" > "Sync Settings" > "Settings - User"
4. Copy/paste settings from 1Password
5. Restart Sublime Text a couple of times :-)

## 11. Download Dash docs

## 12. Terminal theme

Use `~/Repos/dotfiles/.init/MaterialDark.terminal` as default theme
