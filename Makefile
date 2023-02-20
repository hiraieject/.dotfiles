
-include ~/.dotfiles/.makefile.inc

gcommit:
	@make _gcommit_noedit
gpush:
	@make _gpush
gpull:
	@make _gpull
gdiff:
	@make _gdiff
gdiff_commit:
	@make _gdiff_commit

