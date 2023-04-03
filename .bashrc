# .bashrc

export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi
if [ -f /etc/bash.bashrc ]; then
	source /etc/bash.bashrc
fi
export PS1="[\u@\h \W]\$ "

# local custmize
if [ ! -f $HOME/.dotfiles/.bashrc_local ]; then
    cp $HOME/.dotfiles/.bashrc_local.template $HOME/.dotfiles/.bashrc_local
fi
source $HOME/.dotfiles/.bashrc_local

#export PATH=$HOME/mybin/bin:$HOME/bin:$PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/mybin/lib

# User specific aliases and functions
export CVSROOT=":pserver:hirai@10.78.112.116:/usr/local/cvsroot"
export SVNROOT="https://133.181.137.151/FP/repos/"

export TERMAPP='gnome-terminal'
if [ -f /usr/bin/terminator ]; then
	export TERMAPP='terminator'
else
if [ -f /usr/bin/xterm ]; then
	export TERMAPP='xterm'
fi
fi

if [ -d /mingw32/bin ]; then
    export PATH=$PATH:/mingw32/bin:/mingw64/bin
fi


# ----------------------------------------------------- PROXY
if [ ! aa$PROXY_SERVER = 'aaNONE' ]; then
	export proxy="$PROXY_SERVER"
	export HTTPS_PROXY="$PROXY_SERVER"
	export https_proxy="$PROXY_SERVER"
	export HTTP_PROXY="$PROXY_SERVER"
	export http_proxy="$PROXY_SERVER"
	export FTP_PROXY="$PROXY_SERVER"
	export ftp_proxy="$PROXY_SERVER"
else
	unset proxy
	unset HTTPS_PROXY
	unset https_proxy
	unset HTTP_PROXY
	unset http_proxy
	unset FTP_PROXY
	unset ftp_proxy
fi

# ----------------------------------------------------- EDITOR
export EDITOR="emacs"

# ----------------------------------------------------- ALIAS

alias       DIFF='touch DIFF; rm DIFF; ln -s ~/DIFF .; cvs diff -c > ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'

alias langc="export LANG=C"
alias langj="export LANG=ja_JP.utf8"
export LANG=$DEFAULT_LANG

alias       em="export DISPLAY=$XDISPLAY; emacs &"
alias       em86="export DISPLAY=$XDISPLAY; emacs &"
alias       gt="export DISPLAY=$XDISPLAY; export NO_AT_BRIDGE=1; $TERMAPP &"
alias       gt86="export DISPLAY=$XDISPLAY; export NO_AT_BRIDGE=1; $TERMAPP &"
alias       xt="export DISPLAY=$XDISPLAY; export NO_AT_BRIDGE=1; xterm &"

alias       gt862="export DISPLAY=$XDISPLAY2; export NO_AT_BRIDGE=1; $TERMAPP &"

alias       DIFF='touch DIFF; rm DIFF; ln -s ~/DIFF .; cvs diff -c > ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'
alias       SDIFF='export LANG=C; rm -f DIFF; mkdir -p ~/DIFF; ln -s ~/DIFF .; svn diff | tee ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'
alias       GDIFF='export LANG=C; rm -f DIFF; mkdir -p ~/DIFF; ln -s ~/DIFF .; git diff | tee ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'
##alias       PATCH='/usr/bin/patch -p0 --binary'
## 改行コードがCRLFのファイルでも正常に当てるために binary オプションが必要
alias       PATCH='/usr/bin/patch -p0 --binary'

alias       use_gitlab="(cd ~hirai; rm -f .gitconfig; ln -s .gitconfig.pavctgitlab .gitconfig; ls -l .gitconfig)"
alias       use_github="(cd ~hirai; rm -f .gitconfig; ln -s .gitconfig.github .gitconfig; ls -l .gitconfig)"

alias	vpntm='sudo ~hirai/bin/vpntm'
alias	check='sudo ~hirai/bin/vpntm check'

// nuvoton alias on target board
alias	unit='(cd ~/nuvodev/anomaly_detection_soc/nu6_lens_anomaly_detection; bash run_test.sh -unit)'
alias	div='(cd ~/nuvodev/anomaly_detection_soc/nu6_lens_anomaly_detection; bash run_test.sh -div)'
alias	div50='(cd ~/nuvodev/anomaly_detection_soc/nu6_lens_anomaly_detection; bash run_test.sh -div50)'
alias	all='(cd ~/nuvodev/anomaly_detection_soc/nu6_lens_anomaly_detection; bash run_test.sh -all)'
alias	gui='(cd ~/nuvodev/anomaly_detection_soc/nu6_lens_anomaly_detection; bash run_test.sh -gui)'
alias   nop="echo 0 0 > /dev/ttyRPMSG30"

alias   insm7d="(cd ~/nuvodev/anomaly_detection_soc; make install_m7bin_debug)"
alias   insm7r="(cd ~/nuvodev/anomaly_detection_soc; make install_m7bin_release)"
alias   insrpmsg="insmod /lib/modules/5.4.70-2.3.0+g4f2631b022d8/kernel/drivers/rpmsg/imx_rpmsg_tty.ko"
alias   rmrpmsg="rmmod /lib/modules/5.4.70-2.3.0+g4f2631b022d8/kernel/drivers/rpmsg/imx_rpmsg_tty.ko"

case $TERM in
    kterm|xterm|xterm-256color|mlterm|cygwin|vt102)
	_termtitle="\h:\w"
	export PS1="\[\e]0;${_termtitle}\007\]${PS1}"
	;;
esac

if [ -d ${HOME}/local/gcc-arm-none-eabi ] ; then
    export ARMGCC_DIR=${HOME}/local/gcc-arm-none-eabi
    export PATH=$ARMGCC_DIR/bin:${PATH}
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
