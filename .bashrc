# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
export PS1="[\u@\h \W]\$ "

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


# -----------------------------------------------------
export PANASONIC_NETWORK=0

if [ `hostname` = 'ubuntu1804' ]; then
	export PANASONIC_NETWORK=1
fi
if [ `hostname` = 'aqua-centos7' ]; then
	export PANASONIC_NETWORK=1
fi
if [ `hostname` = 'garnet-server' ]; then
        export PANASONIC_NETWORK=1
fi

if [ aa$PANASONIC_NETWORK = 'aa1' ]; then
#	export proxy="http://192.168.0.86:8080"
	export proxy="http://10.77.8.70:8080"
	export HTTPS_PROXY=$proxy
	export https_proxy=$proxy
	export HTTP_PROXY=$proxy
	export http_proxy=$proxy
	export FTP_PROXY=$proxy
	export ftp_proxy=$proxy
else
	unset proxy
	unset HTTPS_PROXY
	unset https_proxy
	unset HTTP_PROXY
	unset http_proxy
	unset FTP_PROXY
	unset ftp_proxy
fi

export EDITOR="emacs"


alias       DIFF='touch DIFF; rm DIFF; ln -s ~/DIFF .; cvs diff -c > ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'

alias langc="export LANG=C"
alias langj="export LANG=ja_JP.utf8"
export LANG=ja_JP.utf8

if [ `hostname` = 'orange' ]; then
    export LANG="C"
fi

alias       em='emacs &'
alias       gt="$TERMAPP &"
export XDISPLAY00=localhost:0.0
alias       em00="export DISPLAY=$XDISPLAY00; emacs &"
alias       gt00="export DISPLAY=$XDISPLAY00; export NO_AT_BRIDGE=1; $TERMAPP &"

export XDISPLAY86=192.168.0.86:0.0
alias       em86="export DISPLAY=$XDISPLAY86; emacs &"
alias       gt86="export DISPLAY=$XDISPLAY86; export NO_AT_BRIDGE=1; $TERMAPP &"

export XDISPLAY16=192.168.1.6:0.0
alias       em16="export DISPLAY=$XDISPLAY16; emacs &"
alias       gt16="export DISPLAY=$XDISPLAY16; export NO_AT_BRIDGE=1; $TERMAPP &"

alias       eq1='cd ~/eq1'
alias       eq1src='cd ~/eq1/current_startup/usr/src/'
alias       sq1='cd ~/sq1'
alias       sq1src='cd ~/sq1/current_SQ1/usr/src/'
alias       wm='cd ~/startup_panaapp'
alias       wmsrc='cd ~/startup_panaapp/current_startupr6752_panaapp/usr/src/'
alias       wb='cd ~/startup_whiteboard'
alias       wbsrc='cd ~/startup_whiteboard/current_startupr6591_whiteboard/usr/src/'


alias       DIFF='touch DIFF; rm DIFF; ln -s ~/DIFF .; cvs diff -c > ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'
alias       SDIFF='export LANG=C; touch DIFF; rm DIFF; ln -s ~/DIFF .; svn diff > ~/DIFF/diff`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`".txt"'
##alias       PATCH='/usr/bin/patch -p0 --binary'
## 改行コードがCRLFのファイルでも正常に当てるために binary オプションが必要
alias       PATCH='/usr/bin/patch -p0 --binary'

alias	vpntm='sudo ~hirai/bin/vpntm'
alias	check='sudo ~hirai/bin/vpntm check'

alias	sethomeip='sudo hostname garnet-server-athome; source ~/.bashrc'


case $TERM in
    kterm|xterm|xterm-256color|mlterm|cygwin|vt102)
	_termtitle="\h:\w"
	export PS1="\[\e]0;${_termtitle}\007\]${PS1}"
	;;
esac
