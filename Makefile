MAKEFLAGS += --no-print-directory

-include ~/.dotfiles/.makefile.gitbase.inc

# ------------------------------------------------ os/app setup
install_code:
	mkdir -p $(HOME)/install
	wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O $(HOME)/install/code_latest.deb
	sudo apt install $(HOME)/install/code_latest.deb
uninstall_code:
	sudo apt remove -y code
# ------------------------------------------------ develop folders
REPOSITORIES = \
  .dotfiles \
  docs devprivate devwork devbinfile devdiff
WSLREPOSITORIES = \
  devwsl

cloneall pullall statusall gcommitall:
	@set -e; for repo in $(REPOSITORIES); do \
		echo "### =================== $$repo"; \
		$(MAKE) sub_$@ REPO=$$repo BASE=~; \
	done
	@set -e; for repo in $(WSLREPOSITORIES); do \
		if [ -d ~/wsl ] ; then \
			echo "### =================== $$repo"; \
			$(MAKE) sub_$@ REPO=$$repo BASE=~/wsl; \
			rm -f $$repo; ln -s ~/wsl/$$repo .; \
		fi;\
	done

sub_cloneall:
	@set -e; if [ ! -d $(BASE)/$(REPO) ] ; then \
		(cd $(BASE); git clone https://hiraieject@github.com/hiraieject/$(REPO)); \
	fi
sub_pullall:
	@set -e; if [ -d $(BASE)/$(REPO) ] ; then \
		(cd $(BASE)/$(REPO); pwd; git pull); \
	fi
sub_statusall:
	@set -e; if [ -d $(BASE)/$(REPO) ] ; then \
		(cd $(BASE)/$(REPO); pwd; git status); \
	fi
sub_gcommitall:
	@set -e; if [ -d $(BASE)/$(REPO) ] ; then \
		(cd $(BASE)/$(REPO); make gcommit); \
	fi

# ------------------------------------------------

# ------------------------------------------------ 
update_certfile:
	sudo apt update
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

