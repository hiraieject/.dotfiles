
help:
	@echo "## git"
	make git_install
	make git_set_account
	make git_clone_memos
	make git_clone_tgtdev
	make git_clone_pcdev

git_install:
	sudo -E apt update
	sudo -E apt install git

git_set_account:
	git config --global user.name "hiraieject"
	git config --global user.email hirai@eject.org
	git config --global credential.helper store
	@echo 'https://ACCOUNT:PASSWD@github.com' > ~/.git-credentials
	chmod 600 ~/.git-credentials
	@echo 'Please edit ~/.git-credentials'

git_clone_memos:
	(cd ~; git clone https://github.com/hiraieject/memos.git)
git_clone_tgtdev:
	(cd ~; git clone https://github.com/hiraieject/tgtdev.git)
git_clone_pcdev:
	(cd ~; git clone https://github.com/hiraieject/pcdev.git)
