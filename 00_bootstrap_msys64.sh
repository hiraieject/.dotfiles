#!/bin/sh

sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/msys2.ini
sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/mingw32.ini
sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/mingw64.ini
sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/clang32.ini
sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/clang64.ini
sed -i 's/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g' /c/msys64/clangarm64.ini

echo 'NEXT STEP REBOOT'
