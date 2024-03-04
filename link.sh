#!/bin/sh

export BAKDATE=`date +%y%m%d%H%M`

if [ -f ~/.bashrc ] ; then
    /bin/rm -f ~/.bashrc.$BAKDATE
    mv ~/.bashrc ~/.bashrc.$BAKDATE
fi
ln -s ~/.dotfiles/.bashrc ~/.bashrc

if [ -f ~/.gdbinit ] ; then
    /bin/rm -f ~/.gdbinit.$BAKDATE
    mv ~/.gdbinit ~/.gdbinit.$BAKDATE
fi
ln -s ~/.dotfiles/.gdbinit ~/.gdbinit

if [ -d ~/.emacs.d ] ; then
    /bin/rm -f ~/.emacs.d.$BAKDATE
    mv ~/.emacs.d ~/.emacs.d.$BAKDATE
fi
ln -s ~/.dotfiles/.emacs.d ~/.emacs.d

if [ ! -f $HOME/.dotfiles/.bashrc_local ]; then
    cp $HOME/.dotfiles/.bashrc_local.template $HOME/.dotfiles/.bashrc_local
fi

if [ ! -f ~/.openai-credential ] ; then
    cp .openai-credential-template ~/.openai-credential
fi
#export OPENAI_API_KEY=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
