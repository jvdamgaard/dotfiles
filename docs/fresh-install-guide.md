# Fresh Install Guide

## 1. Clean install OSX

[Google](https://www.google.dk/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=clean%20install%20os%20x)

## 2. Install x-code

## 3. Install dependencies

Install ruby, homebrew and git:

```bash
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew install git
```

## 4. Clone dotfiles repository

```bash
$ git clone https://github.com/jvdamgaard/dotfiles.git ~/Repos/dotfiles
```

## 5. Install dotfiles

```bash
$ source ~/Repos/dotfiles/bootstrap.sh --force
```

## 6. Install applications and services

```bash
$ source ~/Repos/dotfiles/.init/apps.sh
```

## 7. Update osx settings

```bash
$ source ~/Repos/dotfiles/.init/osx.sh
```

## 8. Activate hyper key

1. Go to the System Preferences Keyboard pane and press the “Modifier Keys…” button and set Caps Lock to No Action.
2. Open Karabiner and activate "Remap Caps Lock to Hyper"

## 9. Sync settings

1password:

1. Use dropbox

Alfred:

1. Insert Powerpack license from 1Password
2. Under _Advanced_ choose _Set sync folder..._ and select `~/Dropbox/dokumenter/alfred-sync`

Atom:

1. Add sync settings from 1password
2. Restore

## 10. Download Dash docs

## 11. Change background images

to `~/Dropbox/dokumenter/Background images`

## 12. Terminal theme

Use `~/Repos/dotfiles/.init/MaterialDark.terminal` as default theme
