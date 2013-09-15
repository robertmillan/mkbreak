mkbreak
=======

Generic exploit for master key vulnerability in Android

* Download and install Android SDK from https://developer.android.com/sdk/index.html

* Download Superuser from http://androidsu.com/superuser/ then place Superuser.apk and "su" binary for your architecture (usually ARM) in the checkout directory

* Connect your device to USB and enable USB debugging mode. This changes for different versions of Android:

   - For Gingerbread and Froyo: Settings -> Applications -> Development -> USB debugging

   - For ICS: Settings -> Developer options -> Android debugging

* Run ./doit.sh <path to Android SDK> and follow the instructions

* Enjoy your freedom and get rid of that annoying bloatware / spyware. May I suggest CyanogenMod (http://cyanogenmod.org/)?

Based on:

- research by Jay Freeman (saurik), available at http://www.saurik.com/id/17

- APK injection PoC by Pau Oliva, available at https://github.com/poliva/random-scripts/blob/master/android/masterkey-apk-inject.sh
