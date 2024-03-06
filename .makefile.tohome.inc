
tohome_archive:
	(cd $(PROJ_REPOSITORYNAME); make clean)
	(cd $(PROJ_REPOSITORYNAME); \
	 tar -cvhz $(TOHOME_EXCLUDE) -f../$(PROJ_REPOSITORYNAME).tar.gz *)
	scp -P20022 $(PROJ_REPOSITORYNAME).tar.gz hirai@hirai.cc:~/ToHome/ 

tohome_download:
	scp -P20022 hirai@hirai.cc:~/ToHome/$(PROJ_REPOSITORYNAME).tar.gz .

tohome_extract:
	@make tohome_download
	make newtree
	(cd $(PROJ_REPOSITORYNAME); rm -rf src)
	(cd $(PROJ_REPOSITORYNAME); tar xvf ../$(PROJ_REPOSITORYNAME).tar.gz)
	(cd $(PROJ_REPOSITORYNAME); git status)
