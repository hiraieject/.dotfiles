#!/bin/bash

sudo apt update

sudo apt -y install --reinstall ca-certificates

sudo apt -y install build-essential cmake git
sudo apt -y install emacs net-tools global emacs-mozc-bin
sudo apt -y install xterm
sudo apt -y install curl
sudo apt -y install cifs-utils
sudo apt -y install nodejs npm

## Node.js
sudo npm config set strict-ssl false
sudo npm install n -g  # update latest

## Python
sudo apt -y install python3 python3-pip python-is-python3
pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org openpyxl
pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org pylint

## old
rm -rf ~/.node
