#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "README.md" --exclude ".gitignore" -av --no-perms . ~
    source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt