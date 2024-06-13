
tohome_archive:
	@make tohome_archive_local
	scp -P20022 ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz hirai@hirai.cc:~/ToHome/ 

tohome_download:
	scp -P20022 hirai@hirai.cc:~/ToHome/$(PROJ_REPOSITORYNAME).tar.gz .

tohome_extract:
	@make tohome_download
	@make tohome_extract_local:

tohome_archive_local:
	mkdir -p ~/tohome
	(cd $(PROJ_REPOSITORYNAME); make clean)
	(cd $(PROJ_REPOSITORYNAME); \
	tar -cvhz $(TOHOME_EXCLUDE) -f ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz * .??*)

tohome_extract_local:
	make newtree
	(cd $(PROJ_REPOSITORYNAME); rm -rf src)
	(cd $(PROJ_REPOSITORYNAME); tar xvf ~/tohome/$(PROJ_REPOSITORYNAME).tar.gz)
	(cd $(PROJ_REPOSITORYNAME); git status)
