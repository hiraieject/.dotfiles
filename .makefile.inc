
_gcommit:
	git pull
	make _gdiff_commit
	git commit .
	git push
	
_gcommit_noedit:
	git pull
	make _gdiff_commit
	git commit . -m "commit diff"
	git push
	
_gpull:
	git pull
_gpush:
	git push
_gdiff:
	-git diff
_gdiff_commit:
	-git diff | tee ~/pcdev/diff/diff_commit_`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`.txt
	-(cd ~/pcdev/diff; git pull; git add *.txt; git commit -m "commit diff" .; git push)


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
