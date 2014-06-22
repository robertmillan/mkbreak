#!/bin/bash
set -e

function adb_reboot()
{
	echo "Press ENTER to reboot phone"
	read
	adb reboot
	echo "Waiting for device..."
	adb wait-for-device
}

if [ ! "$1" ] ; then
	echo "Usage: $0 <sdk directory>" >&2
	exit 1
fi

SDK="$1"

echo $TOOLS
export PATH=${SDK}/platform-tools:${TOOLS}:$PATH

which adb

system_dev=$(adb shell mount | grep " /system " | cut -d ' ' -f 1)

adb shell su -c "mount -o remount,rw ${system_dev} /system"
adb shell su -c "rm /system/xbin/su /system/app/Superuser.apk"

adb_reboot

echo "Done!"

exit 0
