# Fresh Install Guide

## 1. Install dependencies

Install ruby:

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
