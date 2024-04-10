#!/bin/bash

sudo apt update
sudo apt -y install build-essential
sudo apt -y install git
sudo apt -y install --reinstall ca-certificates
sudo apt -y install emacs net-tools global
sudo apt -y install xterm
sudo apt -y install emacs-mozc-bin
sudo apt -y install curl
sudo apt -y install cifs-utils

## SSH KEY(no pass)
if [ ! -d ~/.ssh ] ; then
    ssh-keygen -t rsa -b 4096 -N ""
    ls -l ~/.ssh/id_rsa*
fi

## NODE.JS
if [ ! -f ~/.node/bin/node ] ; then
    ./install_nodejs.sh
fi

## Python
sudo apt install python3-pip
pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org openpyxl

