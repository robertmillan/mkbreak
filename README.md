mkbreak
=======

Generic exploit for master key vulnerability in Android

1. Download and install Android SDK from https://developer.android.com/sdk/index.html

2. Download Superuser from http://androidsu.com/superuser/ then place Superuser.apk and "su" binary for your architecture (usually ARM) in the checkout directory

3. Run ./doit.sh <path to Android SDK> and follow the instructions

4. Enjoy your freedom and get rid of that annoying bloatware / spyware. May I suggest CyanogenMod (http://cyanogenmod.org/)?

Based on:

- research by Jay Freeman (saurik), available at http://www.saurik.com/id/17

- APK injection PoC by Pau Oliva, available at https://github.com/poliva/random-scripts/blob/master/android/masterkey-apk-inject.sh
