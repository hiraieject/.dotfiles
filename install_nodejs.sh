sudo apt update
sudo apt install -y curl

#export FOLDER=v21.6.1
#export FNAME=node-v21.6.1-linux-x64
export FOLDER=v20.11.0
export FNAME=node-$FOLDER-linux-x64

curl --insecure https://nodejs.org/dist/$FOLDER/$FNAME.tar.xz --output $FNAME.tar.xz
(cd $HOME; tar xvf .dotfiles/$FNAME.tar.xz; mv $FNAME .$FNAME; rm -f .node; ln -s .$FNAME .node)
rm $FNAME.tar.xz

## ##https://nodejs.org/dist/v21.6.1/node-v21.6.1-linux-x64.tar.xz
## ## https://github.com/nvm-sh/nvm#install--update-script
## 
## #curl --insecure -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
## #export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
## #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
## #nvm ls-remote
## #nvm install 20
## #nvm use 20
## 
## ## https://www.kkaneko.jp/tools/ubuntu/ubuntu_nodejs.html
## ##  nvm ls-remote
## ##  nvm install 16.16.0
## ##  nvm list
## ##  nvm use 16.16.0
## 
## # node.js の最新を取りたい場合は、nvm ls-remote でインストール可能なバージョンの一覧を取得し、
## # 本スクリプトの nvm install,use のところを書き換えて実行する
