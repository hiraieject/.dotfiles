DIFFFOLDER    ?= ~/diff-folder
DATE_STRING   ?= $(shell date +%Y%m%d_%H%M%S)

## # ------------------------------------------------ svn
scommitm:
	@make __TGTFOLDER=$(__TGTFOLDER) _scommit
	(cd $(__TGTFOLDER); svn status)
scommit:
	@make __TGTFOLDER=$(__TGTFOLDER) _scommit_noedit
	(cd $(__TGTFOLDER); svn status)


_scommit:
##	(cd $(__TGTFOLDER); svn update)
	make __TGTFOLDER="$(__TGTFOLDER)" _sdiff_commit
	-(cd $(__TGTFOLDER); svn ci .)
	
_scommit_noedit:
##	(cd $(__TGTFOLDER); svn update)
	make __TGTFOLDER="$(__TGTFOLDER)" _sdiff_commit
	-(cd $(__TGTFOLDER); git ci . -m "today's snapshot")
	
_sdiff:
	(cd $(__TGTFOLDER); svn diff > $(DIFFFOLDER)/diff_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)

_sdiff_commit:
	(cd $(__TGTFOLDER); svn diff > $(DIFFFOLDER)/diff_commit_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add *.txt; git commit -m "commit diff" .; git push)

_sstatus:
	svn status


get_reference_tree:
	svn co -r $(REV) `cat .svnbase`/`cat .svnfolder` `cat .targetmodel`_$(REV)

get_refrence_headtree:
	svn co `cat .svnbase`/`cat .svnfolder` `cat .targetmodel`_HEAD
	