# Device

Device functionalities.


## Battery
* Pub: https://pub.dev/packages/battery

* [Example](lib/screen/battery_screen.dart)
  * Listen Battery state in three state { Full, Charging, Discharging }
  * Show current battery level at percentage



## Device Info

* Pub: https://pub.dev/packages/device_info
* [Example](lib/screen/info_screen.dart)
  * Distinguish Android and iOS platform using `io` and `services` package 
  * Use `DeviceInfoPlugin` to reach the device data



## Package Info

* Pub: https://github.com/flutter/plugins/tree/master/packages/package_info
* [Example](lib/screen/package_screen.dart)
  * Use `PackageInfo` to get `AppName`, `PackageName`, `AppVersion`, `BuildNumber`



## Path Provider

* Pub: https://pub.dev/packages/path_provider
* Cookbook: https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  * Teach you how to use `MethodChannel` to test.
* [Example](lib/screen/path_provider_screen.dart)
  * Get the paths of `TempDirectory`, `AppDocumentsDirectory`, `AppSupportDirectory (iOS only)`, `ExternalDocumentsDirectory (Android only)`
  * Write some data to the file, and read it from the file.



## Camera



## Image Picker



## Video



## Google Maps



## Sensor