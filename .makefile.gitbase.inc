
## # ------------------------------------------------ template
#USE_PAVCT_GIT = yes
#PROJ_REPOSITORYNAME = emmcimguty
#ARCHIVE_REPOSITORYNAME = emmcimguty_archives
#DIFFFOLDER    = ~/diff-folder
#-include ~/.dotfiles/.makefile.gitbase.inc

## # ------------------------------------------------ 

HOSTNAME := $(shell hostname)

PAVCT_GIT = git@172.16.171.224:hirai.yoshikazu

ifeq ($(USE_PAVCT_GIT), yes)
     PROJ_GITURL ?= $(PAVCT_GIT)
endif

PROJ_GITURL ?= https://github.com/hiraieject

DIFFFOLDER    ?= ~/diff-folder
DATE_STRING   ?= $(shell date +%Y%m%d_%H%M%S)


CURRENTFILE = .current_folder
ACURRENTFILE = .archive_current_folder

.PHONY: helper

helper:
	@echo 'make newtree		## get newtree'
	@echo 'make remove_current	## remove current tree'
	@echo 'make remove_all		## remove all tree'

newtree:
	echo $(DATE_STRING)_$(PROJ_REPOSITORYNAME) > $(CURRENTFILE)

	git clone $(PROJ_GITURL)/$(PROJ_REPOSITORYNAME) `cat $(CURRENTFILE)`
	(cd  `cat $(CURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_current

newarchive:
	echo $(DATE_STRING)_$(ARCHIVE_REPOSITORYNAME) > $(ACURRENTFILE)

	git clone $(PROJ_GITURL)/$(ARCHIVE_REPOSITORYNAME) `cat $(ACURRENTFILE)`
	(cd  `cat $(ACURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_acurrent

link_current:
	rm -rf $(PROJ_REPOSITORYNAME)
	-ln -s `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)

link_acurrent:
	rm -rf $(ARCHIVE_REPOSITORYNAME)
	-ln -s `cat $(ACURRENTFILE)` $(ARCHIVE_REPOSITORYNAME)

remove_current:
	rm -rf `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)

remove_acurrent:
	rm -rf `cat $(ACURRENTFILE)` $(ARCHIVE_REPOSITORYNAME)
	rm -f $(ACURRENTFILE)

remove_all:
	rm -rf *_$(PROJ_REPOSITORYNAME) $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)
	rm -rf *_$(ARCHIVE_REPOSITORYNAME) $(ARCHIVE_REPOSITORYNAME)
	rm -f $(ACURRENTFILE)

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
	(cd $(__TGTFOLDER); git diff > $(DIFFFOLDER)/diff_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
_gdiff_commit:
	(cd $(__TGTFOLDER); git diff > $(DIFFFOLDER)/diff_commit_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add *.txt; git commit -m "commit diff" .; git push)
_gstatus:
	git status


