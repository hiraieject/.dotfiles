

clone_copilot:
	git clone https://github.com/zerolfx/copilot.el.git

install_nodejs:
	bash install_nodejs.sh

# ------------------------------------------------ git
-include ~/.dotfiles/.makefile.inc
gcommit:
	@make __TGTFOLDER="." _gcommit_noedit
gpush:
	@make __TGTFOLDER="." _gpush
gpull:
	@make __TGTFOLDER="." _gpull
gdiff:
	@make __TGTFOLDER="." _gdiff
gdiff_commit:
	@make __TGTFOLDER="." _gdiff_commit
gstatus:
	@make __TGTFOLDER="." _gstatus
