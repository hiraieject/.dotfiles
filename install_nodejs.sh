sudo apt update
sudo apt install -y curl

## https://github.com/nvm-sh/nvm#install--update-script

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm ls-remote
nvm install 20
nvm use 20

## https://www.kkaneko.jp/tools/ubuntu/ubuntu_nodejs.html
##  nvm ls-remote
##  nvm install 16.16.0
##  nvm list
##  nvm use 16.16.0

# node.js の最新を取りたい場合は、nvm ls-remote でインストール可能なバージョンの一覧を取得し、
# 本スクリプトの nvm install,use のところを書き換えて実行する
