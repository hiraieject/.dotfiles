#!/bin/bash

sudo apt update
sudo apt -y install build-essential
sudo apt -y install git
sudo apt -y install --reinstall ca-certificates
sudo apt -y install emacs net-tools global
sudo apt -y install xterm
sudo apt -y install emacs-mozc-bin

if [ ! -f ~/.gitconfig ] ; then
    git config --global user.email "hiraieject@gmail.com"
    git config --global user.name "hiraieject"
fi
git config --global credential.helper store
git config pull.rebase false
git config --global http.sslverify false
git config --global --add merge.ff false
git config --global --add pull.ff only

if [ ! -f ~/.git-credentials ] ; then
    echo 'https://hiraieject@gmail.com:@github.com' > ~/.git-credentials
    chmod og-rwx ~/.git-credentials
    echo Please edit ~/.git-credentials
fi

if [ ! -f ~/.node/bin/node ] ; then
    ./install_nodejs.sh
fi

