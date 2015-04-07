# Fresh Install Guide

## 1. Install dependencies

Install ruby, homebrew and git:

```bash
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Install HomeBrew

```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install git

```bash
$ brew install git
```

## 2. Clone dotfiles repository

```bash
$ git clone https://github.com/jvdamgaard/dotfiles.git ~/Repos/dotfiles
```

## 3. Install dotfiles

```bash
$ source ~/Repos/dotfiles/bootstrap.sh --force
```

## 4. Install applications and services

```bash
$ source ~/Repos/dotfiles/.init/apps.sh
```

## 5. Update osx settings

```bash
$ source ~/Repos/dotfiles/.init/osx.sh
```

## 6. Activate hyper key

1. Go to the System Preferences Keyboard pane and press the “Modifier Keys…” button and set Caps Lock to No Action.
2. Open Karabiner and activate "Remap Caps Lock to Hyper"

## 7. Sync settings

1. Open Alfred App
2. Under _Advanced_ choose _Set sync folder..._ and select `~/Dropbox/dokumenter/alfred-sync`

## 8. Download Dash docs

## 9. Change background images

to `~/Dropbox/dokumenter/Background images`
