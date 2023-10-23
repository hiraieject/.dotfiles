
CURRENTFILE = .current_folder

.PHONY: helper

helper:
	@echo 'make newtree		## get newtree'
	@echo 'make remove_current	## remove current tree'
	@echo 'make remove_all		## remove all tree'

newtree:
	echo `date "+%y%m%d_%H%M%S"`_$(GITREPOSITORY) > $(CURRENTFILE)

	git clone $(GITURL)/$(GITREPOSITORY) `cat $(CURRENTFILE)`
	(cd  `cat $(CURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_current

link_current:
	rm -rf $(GITREPOSITORY)
	-ln -s `cat $(CURRENTFILE)` $(GITREPOSITORY)

remove_current:
	rm -rf `cat $(CURRENTFILE)` $(GITREPOSITORY)
	rm -f $(CURRENTFILE)

remove_all:
	rm -rf *_$(GITREPOSITORY) $(GITREPOSITORY)
	rm -f $(CURRENTFILE)

## # ------------------------------------------------ git
gcommitm:
#	@make __TGTFOLDER="." _gcommit_noedit
	@make __TGTFOLDER="." _gcommit
gcommit:
	@make __TGTFOLDER="." _gcommit_noedit
#	@make __TGTFOLDER="." _gcommit
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


_gcommit:
	(cd $(__TGTFOLDER); git pull)
	make __TGTFOLDER="$(__TGTFOLDER)" _gdiff_commit
	-(cd $(__TGTFOLDER); git commit .)
	(cd $(__TGTFOLDER); git push)
	
_gcommit_noedit:
	(cd $(__TGTFOLDER); git pull)
	make __TGTFOLDER="$(__TGTFOLDER)" _gdiff_commit
	-(cd $(__TGTFOLDER); git commit . -m "today's snapshot")
	(cd $(__TGTFOLDER); git push)
	
_gpull:
	(cd $(__TGTFOLDER); git pull)
_gpush:
	(cd $(__TGTFOLDER); git push)
_gdiff:
	(cd $(__TGTFOLDER); git diff)
_gdiff_commit:
	(cd $(__TGTFOLDER); git diff > $(DIFFFOLDER)/diff_commit_`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add *.txt; git commit -m "commit diff" .; git push)
_gstatus:
	git status


