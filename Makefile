
-include ~/.dotfiles/.makefile.gitbase.inc

# ------------------------------------------------
clone_develops:
	@set -e; if [ ! -d ~/en-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/en-develop); \
	fi
	@set -e; if [ ! -d ~/pj-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/pj-develop); \
	fi
	@set -e; if [ ! -d ~/fp-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/fp-develop); \
	fi
	@set -e; if [ ! -d ~/private-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/private-develop); \
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
	@set -e; if [ ! -d ~/windows-setup ] ; then \
		(cd ~; git clone https://github.com/hiraieject/windows-setup); \
	fi
	@set -e; if [ ! -d ~/linux-setup ] ; then \
		(cd ~; git clone https://github.com/hiraieject/linux-setup); \
	fi

# ------------------------------------------------ 
update_certfile:
	sudo apt update
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

