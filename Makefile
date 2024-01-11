
install_nodejs:
	bash install_nodejs.sh

# ------------------------------------------------ git
-include ~/.dotfiles/.makefile.gitbase.inc

config_git:
	git config --global user.email "you@example.com"
	git config --global user.name "account name"
	git config --global credential.helper store
	git config pull.rebase false
	@echo 'https://YOUR_ACCOUNT:YOUR_TOKEN@github.com' > ~/.git-credentials
	@chmod og-rwx ~/.git-credentials
	@echo Please edit ~/.git-credentials,  ~/.gitconfig

##  "server certificate verification failed. CAfile: /home/<user>/.ssl/trusted.pem CRLfile: none" エラー対策
config_git_no_sslverify:
	git config --global http.sslverify false

update_certfile:
	sudo apt install apt-transport-https ca-certificates
	sudo update-ca-certificates

