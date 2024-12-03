## -*- Mode: Makefile -*- ##

tohome_archive tohome_download tohome_extract tohome_archive_local tohome_extract_local tohome_extract_local_nonewtree:
	make _$@

_tohome_archive:
	@make tohome_archive_local
	scp -P20022 ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz hirai@hirai.cc:~/ToHome/ 

_tohome_download:
	scp -P20022 hirai@hirai.cc:~/ToHome/$(PROJ_REPOSITORYNAME).tar.gz .

_tohome_extract:
	@make tohome_download
	@make tohome_extract_local

_tohome_archive_local:
	mkdir -p ~/tohome
	(cd $(PROJ_REPOSITORYNAME); make clean)
	(cd $(PROJ_REPOSITORYNAME); \
	 tar -cvhz $(TOHOME_EXCLUDE) -f ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz * .??*)

_tohome_extract_local:
	make newtree
	make _tohome_extract_local_nonewtree

_tohome_extract_local_nonewtree:
	(cd $(PROJ_REPOSITORYNAME); rm -rf src)
	(cd $(PROJ_REPOSITORYNAME); tar xvf ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz)
	(cd $(PROJ_REPOSITORYNAME); git status)

# new target
_folder_archive:
	(cd $(FOLDER); touch .aaaaa; tar -cvhz $(TOHOME_EXCLUDE) -f ~/tohome/$(ARCHIVENAME) * .??*; rm .aaaaa)
	ls -l ~/tohome/
_folder_clean_archive:
	(cd $(FOLDER); make clean)
	@make FOLDER=$(FOLDER) ARCHIVENAME=$(ARCHIVENAME) _folder_archive
_folder_extract:
	ls -l ~/tohome/$(ARCHIVENAME)
	(cd $(FOLDER); tar xvf ~/tohome/$(ARCHIVENAME); rm .aaaaa)
	(cd $(FOLDER); git status)

_archive_upload:
	scp -P20022 ~/tohome/$(ARCHIVENAME) hirai@hirai.cc:~/ToHome/ 

_archive_download:
	scp -P20022 hirai@hirai.cc:~/ToHome/$(ARCHIVENAME) ~/tohome
