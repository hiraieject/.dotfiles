
###### emacs 環境構築メモ ######

以下は、emacs27以降が必要
ubuntu20.04はNG、22.04はOK

NGの場合は EMACSSTRAIGHT=NO 設定で使うこと
この場合でもmozcの漢字変換やboiled-eggは使える

~/.dotfiles/.bashrc_local が無ければテンプレートから作成し、
export EMACSSTRAIGHT=YES　の行を有効にする

~/.dotfiles/.emacs.d/.secret.el が無ければテンプレートから作成し、
OpenAI のキーを設定して、以下のパーミッションを設定
chmod og-rwx .secret.el

source .bashrc をしてから、emacs を起動
自動設定にはしばらくかかる

sudo にパスワードが必要な設定になっている場合はエラーになるので
手動 install_nodejs.sh を走らせて emacs を再起動


