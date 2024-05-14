@echo off

:: 管理者権限での実行をチェック
net session >nul 2>&1
if %errorLevel% == 0 (
    echo admin
) else (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit
)

if not exist c:\cygwin64_files (
  md c:\cygwin64_files
)
c:
cd \cygwin64_files
set SETUPFILE=setup-x86_64.exe
set URL=https://www.cygwin.com/setup-x86_64.exe

if not exist "%SETUPFILE%" (
    echo %SETUPFILE% not found, downloading...
    curl -k -O %URL%
)

%SETUPFILE% --root c:\cygwin64 --local-package-dir c:\cygwin64_files --site http://ftp.iij.ad.jp/pub/cygwin/ --quiet-mode --packages gcc-core,gcc-g++,git,make,cmake,patch,python3,python3-pip,python3-venv,python3-tk,libexpat1,python3-devel,libncurses-devel,openssl-devel,libboost-devel,readline-devel,libsqlite3-devel,libxml2-devel,libxslt-devel,wget,emacs-gtk,emacs-anthy,xterm,gdb

rem install sygserver as service
set CYGWIN_HOME=C:\cygwin64
set BASH=%CYGWIN_HOME%\bin\bash.exe
%BASH% --login -c "/usr/bin/cygserver-config -y"

rem start sygserver service
net start "CYGWIN cygserver"

pause

