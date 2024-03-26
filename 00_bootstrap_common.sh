#!/bin/sh

export BAKDATE=`date +%y%m%d%H%M$S`
mkdir -p ~/.dotfiles.bak
mkdir -p ~/DIFF

if [ -f ~/.bashrc ] ; then
    mv ~/.bashrc ~/.dotfiles.bak/.bashrc.$BAKDATE
fi
ln -s ~/.dotfiles/.bashrc ~/.bashrc

if [ -f ~/.gdbinit ] ; then
    mv ~/.gdbinit ~/.dotfiles.bak/.gdbinit.$BAKDATE
fi
ln -s ~/.dotfiles/.gdbinit ~/.gdbinit

if [ -d ~/.emacs.d ] ; then
    mv ~/.emacs.d ~/.dotfiles.bak/.emacs.d.$BAKDATE
fi
ln -s ~/.dotfiles/.emacs.d ~/.emacs.d

if [ -d ~/Makefile ] ; then
    mv ~/Makefile ~/.dotfiles.bak/Makefile.$BAKDATE
fi
ln -s ~/.dotfiles/Makefile ~/Makefile

if [ ! -f ~/.dotfiles/.bashrc_local ]; then
    cp ~/.dotfiles/.bashrc_local.template $HOME/.dotfiles/.bashrc_local
fi
