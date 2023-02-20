

## # ------------------------------------------------ git
## -include ~/.dotfiles/.makefile.inc
## gcommit:
## 	@make __TGTFOLDER="." _gcommit_noedit
## #	@make __TGTFOLDER="." _gcommit
## gpush:
## 	@make __TGTFOLDER="." _gpush
## gpull:
## 	@make __TGTFOLDER="." _gpull
## gdiff:
## 	@make __TGTFOLDER="." _gdiff
## gdiff_commit:
## 	@make __TGTFOLDER="." _gdiff_commit
## gstatus:
## 	@make __TGTFOLDER="." _gstatus


_gcommit:
	(cd $(__TGTFOLDER); git pull)
	make __TGTFOLDER="$(__TGTFOLDER)" _gdiff_commit
	(cd $(__TGTFOLDER); git commit .)
	(cd $(__TGTFOLDER); git push)
	
_gcommit_noedit:
	(cd $(__TGTFOLDER); git pull)
	make __TGTFOLDER="$(__TGTFOLDER)" _gdiff_commit
	(cd $(__TGTFOLDER); git commit . -m "commit diff")
	(cd $(__TGTFOLDER); git push)
	
_gpull:
	(cd $(__TGTFOLDER); git pull)
_gpush:
	(cd $(__TGTFOLDER); git push)
_gdiff:
	(cd $(__TGTFOLDER); git diff)
_gdiff_commit:
	(cd $(__TGTFOLDER); git diff > ~/pcdev/diff/diff_commit_`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`.txt)
	(cd ~/pcdev/diff; git pull; git add *.txt; git commit -m "commit diff" .; git push)
_gstatus:
	git status


nuvodev_gcommit:
	(cd ~/nuvodev; make gcommit)
nuvodev_gpull:
	(cd ~/nuvodev; make gpull)
nuvodev_gpush:
	(cd ~/nuvodev; make gpush)

pcdev_gcommit:
	(cd ~/pcdev; make gcommit)
pcdev_gpull:
	(cd ~/pcdev; make gpull)
pcdev_gpush:
	(cd ~/pcdev; make gpush)

ccv_gcommit:
	(cd ~/pcdev/ccv/cuurent_ccv; make gcommit)
ccv_gpull:
	(cd ~/pcdev/ccv/cuurent_ccv; make gpull)
ccv_gpush:
	(cd ~/pcdev/ccv/cuurent_ccv; make gpush)

linuxenv_gcommit:
	(cd ~/linuxenv; make gcommit)
linuxenv_gpull:
	(cd ~/linuxenv; make gpull)
linuxenv_gpush:
	(cd ~/linuxenv; make gpush)

dotfiles_gcommit:
	(cd ~/linuxenv; make gcommit)
dotfiles_gpull:
	(cd ~/linuxenv; make gpull)
dotfiles_gpush:
	(cd ~/linuxenv; make gpush)
