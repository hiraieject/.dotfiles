
## # ------------------------------------------------ template
#PROJ_REPOSITORYNAME = emmcimguty
#DIFFFOLDER    = ~/diff-folder

#CLONE_OPTION = -b BRANCH_NAME          option, enable if add git commandline option
#ARCHIVE_REPOSITORYNAME = emmcimguty_archives
#                                       option, enable if use archive repository
#USE_PAVCT_GIT = yes                    option, enable if use pavct git
#PAVCT_GITUSER = hirai.yoshikazu        option, enable if use other git username

#-include ~/.dotfiles/.makefile.gitbase.inc


## # ------------------------------------------------ 

HOSTNAME := $(shell hostname)

ifeq ($(USE_PAVCT_GIT), yes)
     GITUSER     ?= hirai.yoshikazu
     PAVCT_GIT   ?= git@172.16.179.142:$(GITUSER)
     PROJ_GITURL ?= $(PAVCT_GIT)
else
     GITUSER     ?= hiraieject
     PROJ_GITURL ?= https://github.com/$(GITUSER)
endif


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
	make _$@
_newtree:
	echo $(DATE_STRING)_$(PROJ_REPOSITORYNAME) > $(CURRENTFILE)

	git clone $(CLONE_OPTION) $(PROJ_GITURL)/$(PROJ_REPOSITORYNAME) `cat $(CURRENTFILE)`
	(cd  `cat $(CURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_current

newarchive:
	make _$@
_newarchive:
	echo $(DATE_STRING)_$(ARCHIVE_REPOSITORYNAME) > $(ACURRENTFILE)

	git clone $(CLONE_OPTION) $(PROJ_GITURL)/$(ARCHIVE_REPOSITORYNAME) `cat $(ACURRENTFILE)`
	(cd  `cat $(ACURRENTFILE)`; find . -name \*.sh -print -exec chmod +x \{} \;)
	make link_acurrent

link_current:
	make _$@
_link_current:
	rm -rf $(PROJ_REPOSITORYNAME)
	-ln -s `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)

link_acurrent:
	make _$@
_link_acurrent:
	rm -rf $(ARCHIVE_REPOSITORYNAME)
	-ln -s `cat $(ACURRENTFILE)` $(ARCHIVE_REPOSITORYNAME)

remove_current:
	make _$@
_remove_current:
	rm -rf `cat $(CURRENTFILE)` $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)

remove_acurrent:
	make _$@
_remove_acurrent:
	rm -rf `cat $(ACURRENTFILE)` $(ARCHIVE_REPOSITORYNAME)
	rm -f $(ACURRENTFILE)

remove_all:
	make _$@
_remove_all:
	rm -rf *_$(PROJ_REPOSITORYNAME) $(PROJ_REPOSITORYNAME)
	rm -f $(CURRENTFILE)
	rm -rf *_$(ARCHIVE_REPOSITORYNAME) $(ARCHIVE_REPOSITORYNAME)
	rm -f $(ACURRENTFILE)

## # ------------------------------------------------ git merge
git githelp:
	@cat ~/.dotfiles/.githelp.md

# ブランチ一覧
lb list_branch:
	git fetch
	git branch -a | cat

	@echo "  =============================="
	@echo "   please set BRANCH_NAME to ENV"
	@echo "     $ export BRANCH_NAME=feature/XXXX"
	@echo "   or add following line to Makefile"
	@echo "     BRANCH_NAME=feature/XXXX"
	@echo "  =============================="

.PHONY: _chk_branchname_env
_chk_branchname_env:
ifeq ($(strip $(BRANCH_NAME)),)
	@echo "  =============================="
	@echo "   ERROR!!!: env BRANCH_NAME is empty"
	@echo "  =============================="
	@exit 1
else
	@echo "BRANCH = $(BRANCH_NAME)"
endif

# 最初に１回やる操作。ローカルに対象ブランチが無い状態のとき、リモートの対象ブランチをローカルに作成して同期、チェックアウトはしない
gb1 get_branch_1st:
	@make _chk_branchname_env
	git fetch
	git branch $(BRANCH_NAME) origin/$(BRANCH_NAME)
	git status

# 最初に１回やる操作。ローカルに対象ブランチが無い状態のとき、リモートの対象ブランチをローカルに作成して同期、チェックアウトする
cb1 checkout_branch_1st:
	@make _chk_branchname_env
	git checkout -b $(BRANCH_NAME) origin/$(BRANCH_NAME)
	git status

# ２回目以降。リモートの対象ブランチをローカルに同期して、チェックアウトする
cb checkout_branch:
	@make _chk_branchname_env
	git fetch
	git checkout $(BRANCH_NAME)
	git status


# リモートの対象ブランチからローカルに同期
pull_from_remote:
	git pull origin $(BRANCH_NAME)

# ローカルの対象ブランチをリモートに同期
push_to_remote:
	git push origin $(BRANCH_NAME)

checkout_remote_branch:
	git checkout $(BRANCH)

## # ------------------------------------------------ git
gcommitam:
	@make __TGTFOLDER="." __COMMITTARGET="" _gcommit
	git status
gcommitm:
	@make __TGTFOLDER="." __COMMITTARGET="" _gcommit
	git status
gcommita:
	@make __TGTFOLDER="." __COMMITTARGET="" _gcommit_noedit
	git status
gcommit:
	@make __TGTFOLDER="." __COMMITTARGET="" _gcommit_noedit
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
	-(cd $(__TGTFOLDER); git commit $(__COMMITTARGET))
	(cd $(__TGTFOLDER); git push)
	
_gcommit_noedit:
	(cd $(__TGTFOLDER); git pull)
	make __TGTFOLDER="$(__TGTFOLDER)" _gdiff_commit
	-(cd $(__TGTFOLDER); git commit $(__COMMITTARGET) -m "today's snapshot")
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


