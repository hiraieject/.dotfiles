
-include ~/.dotfiles/.makefile.gitbase.inc

# ------------------------------------------------
clone_develops:
	@set -e; if [ ! -d ~/develop-nuvo ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-nuvo); \
	fi
	@set -e; if [ ! -d ~/develop-en ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-en); \
	fi
	@set -e; if [ ! -d ~/develop-pj ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-pj); \
	fi
	@set -e; if [ ! -d ~/develop-fp ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-fp); \
	fi
	@set -e; if [ ! -d ~/develop-home ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-home); \
	fi


	@set -e; if [ ! -d ~/diff-folder ] ; then \
		(cd ~; git clone https://github.com/hiraieject/diff-folder); \
	fi
	@set -e; if [ ! -d ~/diff-pj-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/diff-pj-develop); \
	fi
	@set -e; if [ ! -d ~/diff-en-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/diff-en-develop); \
	fi

clone_setups:
	@set -e; if [ ! -d ~/setup-windows ] ; then \
		(cd ~; git clone https://github.com/hiraieject/setup-windows); \
	fi
	@set -e; if [ ! -d ~/setup-linux ] ; then \
		(cd ~; git clone https://github.com/hiraieject/setup-linux); \
	fi

# ------------------------------------------------ 
update_certfile:
	sudo apt update
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

