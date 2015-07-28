# Fresh Install Guide

## 1. Clean install OSX

[Google](https://www.google.dk/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=clean%20install%20os%20x)

## 2. Install dependencies

Install RVM stable with ruby:

```bash
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Install HomeBrew:

```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install git:

```bash
$ brew install git
```

## 3. Clone dotfiles repository

```bash
$ git clone https://github.com/jvdamgaard/dotfiles.git ~/Repos/dotfiles
```

## 4. Install dotfiles

```bash
$ source ~/Repos/dotfiles/bootstrap.sh --force
```

## 5. Install applications and services

```bash
$ source ~/Repos/dotfiles/.init/apps.sh
```

## 6. Update osx settings

```bash
$ source ~/Repos/dotfiles/.init/osx.sh
```

## 7. Activate hyper key

1. Go to the System Preferences Keyboard pane and press the “Modifier Keys…” button and set Caps Lock to No Action.
2. Open Karabiner and activate "Remap Caps Lock to Hyper"

## 8. Sync settings

1password:

1. Use dropbox

Alfred:

1. Open Alfred App
2. Under _Advanced_ choose _Set sync folder..._ and select `~/Dropbox/dokumenter/alfred-sync`

Atom:

1. Open Atom
2. Get sync settings from 1password
3. Restore

## 9. Download Dash docs

## 10. Change background images

to `~/Dropbox/dokumenter/Background images`

## 11. Setup Karabiner and slate

TBD

## 12. Terminal theme

Use `~/Repos/dotfiles/.init/Monokai.terminal` as default theme
