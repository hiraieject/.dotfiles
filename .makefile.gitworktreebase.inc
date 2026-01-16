## -*- Mode: Makefile -*- ##

## # ------------------------------------------------ template
#PROJ_REPOSITORYNAME = emmcimguty
#CLONE_OPTION = -b BRANCH_NAME          option, enable if add git commandline option
#ARCHIVE_REPOSITORYNAME = emmcimguty_archives
#                                       option, enable if use archive repository
#USE_PAVCT_GIT = yes                    option, enable if use pavct git
#PAVCT_GITUSER = hirai.yoshikazu        option, enable if use other git username

#-include ~/.dotfiles/.makefile.gitbase.inc


## # ------------------------------------------------ 

HOSTNAME := $(shell hostname)

GITHUB_GITUSER  ?= hiraieject
GITHUB_GITURL   ?= https://$(GITHUB_GITUSER)@github.com/$(GITHUB_GITUSER)

# USE_PAVCT_GITHUB = yes
# PAVCTGITHUB_GITURL   = https://$(PAVCTGITHUB_GITUSER)@github.com/pavct-organization
PAVCTGITHUB_GITUSER    ?= hirai-yoshikazu_pavct
PAVCTGITHUB_ORG        ?= pavct-organization
PAVCTGITHUB_ORG_GITURL ?= https://$(PAVCTGITHUB_GITUSER)@github.com/pavct-organization
PAVCTGITHUB_GITURL     ?= https://$(PAVCTGITHUB_GITUSER)@github.com/$(PAVCTGITHUB_GITUSER)

PAVCT_GITUSER   ?= hirai.yoshikazu
PAVCT_GITURL    ?= ssh://git@172.16.179.142/$(PAVCT_GITUSER)

PAVCT_GIT2USER  ?= hirai.yoshikazu
PAVCT_GIT2URL   ?= ssh://git@base-gitlab.persol-avct.co.jp:2222/$(PAVCT_GIT2USER)

PAVCT_GIT3USER  ?= hirai.yoshikazu
PAVCT_GIT3URL   ?= ssh://git@172.16.170.145/$(PAVCT_GIT3USER)

#PAVCT_GI3URL    ?= git@base-gitlab.persol-avct.co.jp:2222:$(PAVCT_GITUSER)
#/r2400057/afedevelopment/autoevaluation/eva01_dynamo.git
##PAVCT_GIT2URL   ?= https://base-gitlab.persol-avct.co.jp/r2400057/afedevelopment/autoevaluation/eva01_dynamo.git

DEFAULT_BRANCH      ?= main
FEATURE_BRANCHES    ?= 
COPILOTS_BRANCHES   ?= 


ifeq ($(USE_PAVCT_GIT), yes)
     PROJ_GITURL ?= $(PAVCT_GITURL)
endif
ifeq ($(USE_PAVCT_GIT2), yes)
     PROJ_GITURL ?= $(PAVCT_GIT2URL)
endif
ifeq ($(USE_PAVCT_GIT3), yes)
     PROJ_GITURL ?= $(PAVCT_GIT3URL)
endif
ifeq ($(USE_PAVCT_GITHUB), yes)
     PROJ_GITURL ?= $(PAVCTGITHUB_GITURL)
endif
ifeq ($(USE_PAVCT_GITHUB_ORG), yes)
     PROJ_GITURL ?= $(PAVCTGITHUB_ORG_GITURL)
endif
ifeq ($(USE_GITHUB_HIRAI), yes)
     PROJ_GITURL ?= $(GITHUB_GITURL)
endif
PROJ_GITURL ?= $(GITHUB_GITURL)

DIFFFOLDER    ?= ~/develop-diff
DATE_STRING   ?= $(shell date +%Y%m%d_%H%M%S)
YEAR_STRING   ?= $(shell date +%Y)


CURRENTFILE = .current_folder
ACURRENTFILE = .archive_current_folder

.PHONY: help newtree clonebranches

gitworktreebase_help:
	@echo "=============================="
	@echo 'make newtree		## get newtree'
	@echo 'make cloneall		## clone all subtree'
	@echo 'make pullall		## pull main and all subtree'
	@echo 'make distclean		## remove all tree'
	@echo "=============================="
	@echo 'make FOLDER=feature_XXXX remove_worktree		## remove feature subtree'
	@echo 'make FOLDER=copilot_XXXX remove_worktree		## remove copilot subtree'
	@echo "=============================="

newtree clonebranches newarchive distclean linkcurrent pullall:
	make _$@

cloneall: clonebranches

_newtree:
	echo $(DATE_STRING)_worktree > $(CURRENTFILE)
	mkdir `cat $(CURRENTFILE)`
	make linkcurrent

	(cd worktree/; git clone $(PROJ_GITURL)/$(PROJ_REPOSITORYNAME) $(DEFAULT_BRANCH);)
	(cd worktree/$(DEFAULT_BRANCH); git switch $(DEFAULT_BRANCH))
	rm -f $(DEFAULT_BRANCH); ln -s worktree/$(DEFAULT_BRANCH) $(DEFAULT_BRANCH) 

	make clonebranches

_clonebranches:
	make BRANCHSUB="feature" BRANCHES="$(FEATURE_BRANCHES)" _clonebranches_sub
	make BRANCHSUB="copilot" BRANCHES="$(COPILOT_BRANCHES)" _clonebranches_sub
_clonebranches_sub:
	(cd worktree/$(DEFAULT_BRANCH); git pull)
	@for branch in $(BRANCHES) ; do \
	  if [ ! -d worktree/$(BRANCHSUB)_$$branch ] ; then \
	    echo "--- Adding branch worktree: $(BRANCHSUB)_$$branch ---" ; \
	    echo "(cd worktree/$(DEFAULT_BRANCH); git worktree add ../$(BRANCHSUB)_$$branch $(BRANCHSUB)/$$branch)" ; \
	    (cd worktree/$(DEFAULT_BRANCH); git worktree add ../$(BRANCHSUB)_$$branch $(BRANCHSUB)/$$branch) ; \
	    rm -f $(BRANCHSUB)_$$branch ; ln -s worktree/$(BRANCHSUB)_$$branch $(BRANCHSUB)_$$branch ; \
	  else \
	    echo "Branch worktree already exists: $$branch" ; \
	  fi ; \
	done

_pullall:
	(cd worktree/$(DEFAULT_BRANCH); git pull)
	make BRANCHSUB="feature" BRANCHES="$(FEATURE_BRANCHES)" _pullall_sub
	make BRANCHSUB="copilot" BRANCHES="$(COPILOT_BRANCHES)" _pullall_sub
_pullall_sub:
	@for branch in $(BRANCHES) ; do \
	  if [ -d worktree/$(BRANCHSUB)_$$branch ] ; then \
	    echo "--- UPDATING branch $(BRANCHSUB)_$$branch ---" ; \
	    (cd worktree/$(BRANCHSUB)_$$branch; git pull); \
	  fi ; \
	done

_linkcurrent:
	rm -f worktree; ln -s `cat $(CURRENTFILE)` worktree

_distclean:
	rm -rf worktree *_worktree .current_folder $(DEFAULT_BRANCH)

	make BRANCHSUB="feature" BRANCHES="$(FEATURE_BRANCHES)" _distclean_sub
	make BRANCHSUB="copilot" BRANCHES="$(COPILOT_BRANCHES)" _distclean_sub

_distclean_sub:
	for branch in $(BRANCHES) ; do \
	  rm -f $(BRANCHSUB)_$$branch; \
	done

remove_worktree:
	@echo "--- now remove $(FOLDER) ---" ; \
	(cd $(DEFAULT_BRANCH); git worktree remove ../$(FOLDER)); rm $(FOLDER)

## # ------------------------------------------------ git merge
git githelp:
	@cat ~/.dotfiles/.githelp.md $(DEFAULT_BRANCH) worktree

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
	(cd  `cat $(CURRENTFILE)`; git fetch)
	(cd  `cat $(CURRENTFILE)`; git branch $(BRANCH_NAME) origin/$(BRANCH_NAME))
	(cd  `cat $(CURRENTFILE)`; git status)

# 最初に１回やる操作。ローカルに対象ブランチが無い状態のとき、リモートの対象ブランチをローカルに作成して同期、チェックアウトする
cb1 checkout_branch_1st:
	@make _chk_branchname_env
	(cd  `cat $(CURRENTFILE)`; git checkout -b $(BRANCH_NAME) origin/$(BRANCH_NAME))
	(cd  `cat $(CURRENTFILE)`; git status)

# ２回目以降。リモートの対象ブランチをローカルに同期して、チェックアウトする
cb checkout_branch:
	@make _chk_branchname_env
	(cd  `cat $(CURRENTFILE)`; git fetch)
	(cd  `cat $(CURRENTFILE)`; git checkout $(BRANCH_NAME))
	(cd  `cat $(CURRENTFILE)`; git status)


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
	mkdir -p $(DIFFFOLDER)/$(YEAR_STRING)
	(cd $(__TGTFOLDER); git diff --staged > $(DIFFFOLDER)/$(YEAR_STRING)/diff_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
	(cd $(__TGTFOLDER); git diff >> $(DIFFFOLDER)/$(YEAR_STRING)/diff_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
_gdiff_commit:
	mkdir -p $(DIFFFOLDER)/$(YEAR_STRING)
	(cd $(__TGTFOLDER); git diff --staged > $(DIFFFOLDER)/$(YEAR_STRING)/diff_commit_$(DATE_STRING)-`(pwd | sed "s/.*\///g")`.txt)
	(cd $(DIFFFOLDER); git pull; git add */*.txt; git commit -m "commit diff" .; git push)

_gstatus:
	git status

