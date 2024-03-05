#!/bin/bash

sudo apt update
sudo apt -y install build-essential
sudo apt -y install git
sudo apt -y install --reinstall ca-certificates
sudo apt -y install emacs net-tools global
sudo apt -y install xterm
sudo apt -y install emacs-mozc-bin
sudo apt install -y curl

## SSH KEY(no pass)
if [ ! -d ~/.ssh ] ; then
    ssh-keygen -t rsa -b 4096 -N ""
    ls -l ~/.ssh/id_rsa*
fi

## GIT
if [ ! -f ~/.gitconfig ] ; then
    git config --global user.email "hiraieject@gmail.com"
    git config --global user.name  "hiraieject"
fi
git config --global credential.helper store
git config --global http.sslverify false
git config --global push.default simple
git config --global pull.rebase false
git config --global --add pull.ff only
git config --global merge.ff false

if [ ! -f ~/.git-credentials ] ; then
    echo 'https://hiraieject:TOKEN@github.com' > ~/.git-credentials
    chmod og-rwx ~/.git-credentials
    echo Please edit ~/.git-credentials
fi

## NODE.JS
if [ ! -f ~/.node/bin/node ] ; then
    ./install_nodejs.sh
fi

## Python
sudo apt install python3-pip
pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org openpyxl

## OpenAI
if [ ! -f ~/.openai-credential ] ; then
    cp .openai-credential-template ~/.openai-credential
fi
