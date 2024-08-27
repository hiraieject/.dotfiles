DIFFFOLDER    ?= ~/develop-diff
DATE_STRING   ?= $(shell date +%Y%m%d_%H%M%S)
YEAR_STRING   ?= $(shell date +%Y)

## # ------------------------------------------------ svn

_scommit:
	make __TGTFOLDER="$(__TGTFOLDER)" _sdiff_commit
	-(cd $(__TGTFOLDER); svn ci .; svn status)
	
#_scommit:
#	make __TGTFOLDER="$(__TGTFOLDER)" _sdiff_commit
#	-(cd $(__TGTFOLDER); git ci . -m "today's snapshot";  svn status)
	
_sdiff:
	(cd $(__TGTFOLDER); mkdir -p $(YEAR_STRING); svn diff > $(DIFFFOLDER)/$(YEAR_STRING)/diff_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)

_sdiff_commit:
	(cd $(__TGTFOLDER); mkdir -p $(YEAR_STRING); svn diff > $(DIFFFOLDER)/$(YEAR_STRING)/diff_commit_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add */*.txt; git commit -m "commit diff" .; git push)

_sstatus:
	svn status


get_reference_tree:
	svn co -r $(REV) `cat .svnbase`/`cat .svnfolder` `cat .targetmodel`_$(REV)

get_refrence_headtree:
	svn co `cat .svnbase`/`cat .svnfolder` `cat .targetmodel`_HEAD
	