@echo off
rem set SETUPFILE=setup-x86_64.exe
rem set URL=https://www.cygwin.com/setup-x86_64.exe
set SETUPFILE=setup-x86_32.exe
set URL=https://www.cygwin.com/setup-x86_32.exe

if not exist "%SETUPFILE%" (
    echo %SETUPFILE% not found, downloading...
    curl -k -O %URL%
) else (
    echo %SETUPFILE% already exists.
)

%SETUPFILE% --root c:\cygwin64 --local-package-dir c:\cygwin64_files --site http://ftp.iij.ad.jp/pub/cygwin/ --quiet-mode --packages gcc,git,make,patch,libncurses-devel,openssl-devel,readline,libsqlite3-devel,libxml2-devel,libxslt-devel,wget,apache,emacs-X11,xterm


rem set SETUPFILE=GCMW-1.20.0.exe
rem set URL=https://github.com/microsoft/Git-Credential-Manager-for-Windows/releases/download/1.20.0/GCMW-1.20.0.exe
rem if not exist "%SETUPFILE%" (
rem     echo %SETUPFILE% not found, downloading...
rem     curl -k -O %URL%
rem ) else (
rem     echo %SETUPFILE% already exists.
rem )
rem %SETUPFILE%

pause
