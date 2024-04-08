
-include ~/.dotfiles/.makefile.gitbase.inc

# ------------------------------------------------

cloneall clone_all:
	make clone_develops
	make clone_setups

pullall pull_all:
	make pull_develops
	make pull_setups
	(cd ~/.dotfiles; git pull)

gcommitall gcommit_all:
	make gcommit_develops
	make gcommit_setups
	(cd ~/.dotfiles; make gcommit)


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
	@set -e; if [ ! -d ~/develop-win ] ; then \
		(cd ~; git clone https://github.com/hiraieject/develop-win); \
	fi


	@set -e; if [ ! -d ~/diff-folder ] ; then \
		(cd ~; git clone https://github.com/hiraieject/diff-folder); \
	fi
	@set -e; if [ ! -d ~/diff-pj-develop ] ; then \
		(cd ~; git clone https://github.com/hiraieject/diff-pj-develop); \
	fi

pull_develops:
	@set -e; if [ -d ~/develop-nuvo ] ; then \
		(cd ~/develop-nuvo; pwd; git pull); \
	fi
	@set -e; if [ -d ~/develop-en ] ; then \
		(cd ~/develop-en; pwd; git pull); \
	fi
	@set -e; if [ -d ~/develop-pj ] ; then \
		(cd ~/develop-pj; pwd; git pull); \
	fi
	@set -e; if [ -d ~/develop-fp ] ; then \
		(cd ~/develop-fp; pwd; git pull); \
	fi
	@set -e; if [ -d ~/develop-home ] ; then \
		(cd ~/develop-home; pwd; git pull); \
	fi


	@set -e; if [ -d ~/diff-folder ] ; then \
		(cd ~/diff-folder; pwd; git pull); \
	fi
	@set -e; if [ -d ~/diff-pj-develop ] ; then \
		(cd ~/diff-pj-develop; pwd; git pull); \
	fi
	@set -e; if [ -d ~/diff-en-develop ] ; then \
		(cd ~/diff-en-develop; pwd; git pull); \
	fi

gcommit_develops:
	@set -e; if [ -d ~/develop-nuvo ] ; then \
		(cd ~/develop-nuvo; make gcommit); \
	fi
	@set -e; if [ -d ~/develop-en ] ; then \
		(cd ~/develop-en; make gcommit); \
	fi
	@set -e; if [ -d ~/develop-pj ] ; then \
		(cd ~/develop-pj; make gcommit); \
	fi
	@set -e; if [ -d ~/develop-fp ] ; then \
		(cd ~/develop-fp; make gcommit); \
	fi
	@set -e; if [ -d ~/develop-home ] ; then \
		(cd ~/develop-home; make gcommit); \
	fi
	@set -e; if [ -d ~/develop-win ] ; then \
		(cd ~/develop-win; make gcommit); \
	fi


	@set -e; if [ -d ~/diff-folder ] ; then \
		(cd ~/diff-folder; make gcommit); \
	fi
	@set -e; if [ -d ~/diff-pj-develop ] ; then \
		(cd ~/diff-pj-develop; make gcommit); \
	fi
	@set -e; if [ -d ~/diff-en-develop ] ; then \
		(cd ~/diff-en-develop; make gcommit); \
	fi

clone_setups:
	@set -e; if [ ! -d ~/setup-windows ] ; then \
		(cd ~; git clone https://github.com/hiraieject/setup-windows); \
	fi
	@set -e; if [ ! -d ~/setup-linux ] ; then \
		(cd ~; git clone https://github.com/hiraieject/setup-linux); \
	fi

pull_setups:
	@set -e; if [ -d ~/setup-windows ] ; then \
		(cd ~/setup-windows; pwd; git pull); \
	fi
	@set -e; if [ -d ~/setup-linux ] ; then \
		(cd ~/setup-linux; pwd; git pull); \
	fi

gcommit_setups:
	@set -e; if [ -d ~/setup-windows ] ; then \
		(cd ~/setup-windows; make gcommit); \
	fi
	@set -e; if [ -d ~/setup-linux ] ; then \
		(cd ~/setup-linux; make gcommit); \
	fi


# ------------------------------------------------ 
update_certfile:
	sudo apt update
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

