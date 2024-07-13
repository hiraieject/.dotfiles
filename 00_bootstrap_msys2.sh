#!/bin/sh

export BAKDATE=`date +%y%m%d%H%M$S`
mkdir -p ~/.dotfiles.bak
mkdir -p ~/DIFF

if [ -f ~/.bashrc ] ; then
    cp ~/.bashrc ~/.dotfiles.bak/.bashrc.$BAKDATE
fi
cp ~/.dotfiles/.bashrc ~/.bashrc

if [ -f ~/.gdbinit ] ; then
    cp ~/.gdbinit ~/.dotfiles.bak/.gdbinit.$BAKDATE
fi
cp ~/.dotfiles/.gdbinit ~/.gdbinit

if [ -d ~/.emacs.d ] ; then
    cp -r ~/.emacs.d ~/.dotfiles.bak/.emacs.d.$BAKDATE
fi
cp -r ~/.dotfiles/.emacs.d ~/.emacs.d

if [ -f ~/Makefile ] ; then
    cp ~/Makefile ~/.dotfiles.bak/Makefile.$BAKDATE
fi
cp ~/.dotfiles/Makefile ~/Makefile

if [ ! -f ~/.dotfiles/.bashrc_local ]; then
    cp ~/.dotfiles/.bashrc_local.template ~/.dotfiles/.bashrc_local
fi

## SSH KEY(no pass)
if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -t rsa -b 4096 -N ""
    ls -l ~/.ssh/id_rsa*
fi

# ## GIT
git config --global user.email "hiraieject@gmail.com"
git config --global user.name  "hiraieject"
git config --global credential.helper store
git config --global http.sslverify false
git config --global https.sslverify false
git config --global push.default simple
git config --global pull.rebase false
git config --global pull.ff only
git config --global merge.ff false

if [ ! -f ~/.git-credentials ] ; then
    echo 'https://hiraieject:TOKEN@github.com' > ~/.git-credentials
    chmod og-rwx ~/.git-credentials
    echo Please edit ~/.git-credentials
fi

# ## OpenAI
# if [ ! -f ~/.openai-credential ] ; then
#     cp .openai-credential-template ~/.openai-credential
#     chmod og-rwx ~/.openai-credential
# fi
# 
# ## CIFS
# if [ ! -f ~/.cifs-credential ] ; then
#     cp .cifs-credential-template ~/.cifs-credential
#     chmod og-rwx ~/.cifs-credential
# fi
