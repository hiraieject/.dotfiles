GITURL        ?= https://github.com/hiraieject/
DIFFFOLDER    ?= ~/diff-folder


CURRENTFILE = .current_folder

.PHONY: helper

helper:
	@echo 'make newtree		## get newtree'
	@echo 'make remove_current	## remove current tree'
	@echo 'make remove_all		## remove all tree'

newtree:
	echo `date "+%y%m%d_%H%M%S"`_$(PROJ_REPOSITORYNAME) > $(CURRENTFILE)

	git clone $(GITURL)/$(PROJ_REPOSITORYNAME) `cat $(CURRENTFILE)`
	(cd  `cat $(CURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_current

link_current:
	rm -rf $(PROJ_REPOSITORYNAME)
	-ln -s `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)

remove_current:
	rm -rf `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)

remove_all:
	rm -rf *_$(PROJ_REPOSITORYNAME) $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)

## # ------------------------------------------------ git
gcommitm:
#	@make __TGTFOLDER="." _gcommit_noedit
	@make __TGTFOLDER="." _gcommit
	git status
gcommit:
	@make __TGTFOLDER="." _gcommit_noedit
#	@make __TGTFOLDER="." _gcommit
	git status
gpush:
	@make __TGTFOLDER="." _gpush
	git status
gpull:
	@make __TGTFOLDER="." _gpull
	git status
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
##	(cd $(__TGTFOLDER); git diff)
	(cd $(__TGTFOLDER); git diff > $(DIFFFOLDER)/diff_`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`.txt)
_gdiff_commit:
	(cd $(__TGTFOLDER); git diff > $(DIFFFOLDER)/diff_commit_`date +%y%m%d%H%M-``(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add *.txt; git commit -m "commit diff" .; git push)
_gstatus:
	git status


