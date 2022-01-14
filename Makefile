
git_set_account:
	git config --global user.name "hiraieject"
	git config --global user.email hirai@eject.org
	git config --global credential.helper store
	@echo 'https://ACCOUNT:PASSWD@github.com' > ~/.git-credentials
	chmod 600 ~/.git-credentials
	@echo 'Please edit ~/.git-credentials'
