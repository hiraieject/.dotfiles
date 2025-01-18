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
  MemoData mirrors \
  develop-nuvo develop-en develop-pj develop-fp develop-home develop-ku \
  develop-diff develop-archive

cloneall pullall statusall gcommitall:
	@set -e; for repo in $(REPOSITORIES); do \
		echo "### =================== $$repo"; \
		$(MAKE) sub_$@ REPO=$$repo; \
	done

sub_cloneall:
	@set -e; if [ ! -d ~/$(REPO) ] ; then \
		(cd ~; git clone https://github.com/hiraieject/$(REPO)); \
	fi
sub_pullall:
	@set -e; if [ -d ~/$(REPO) ] ; then \
		(cd ~/$(REPO); pwd; git pull); \
	fi
sub_statusall:
	@set -e; if [ -d ~/$(REPO) ] ; then \
		(cd ~/$(REPO); pwd; git status); \
	fi
sub_gcommitall:
	@set -e; if [ -d ~/$(REPO) ] ; then \
		(cd ~/$(REPO); make gcommit); \
	fi

# ------------------------------------------------

# ------------------------------------------------ 
update_certfile:
	sudo apt update
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

