
_apt_aptupdate:
	@if [ -z "$(shell find /var/lib/apt/periodic/update-success-stamp -mtime -1 2>/dev/null)" ]; then \
		sudo apt update; \
	fi

_apt_install:
	$(MAKE) _apt_aptupdate
	sudo apt install -y $(PACKAGE_NAME)

_apt_uninstall:
	sudo apt remove -y $(PACKAGE_NAME)

_apt_update:
	sudo apt-get --only-upgrade install $(PACKAGE_NAME)

_apt_version:
	@echo '======================================= current version'
	@dpkg-query -W -f='${Package} ${Version}\n' $(PACKAGE_NAME) 2>/dev/null || echo "$(PACKAGE_NAME) is not installed"
	@echo '======================================= available versions'
	@apt-cache policy $(PACKAGE_NAME) | grep 'Candidate\|Installed'

_apt_filelist:
	@echo '======================================= installed files'
	@dpkg -L $(PACKAGE_NAME)

_apt_available:
	@echo '======================================= installed files'
	@apt-cache policy $(PACKAGE_NAME)

_apt_dependencies:
	@echo '======================================= installed files'
	apt-cache depends $(PACKAGE_NAME)

aptupdate:
	$(MAKE) _apt_aptupdate
