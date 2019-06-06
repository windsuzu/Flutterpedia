# Firebase

## Setup

* 首先，先參考[官方文件](https://firebase.google.com/docs/flutter/setup)來設定必要環境與 Firebase 專案。

  * Build Flutter Environment
  * [Create Firebase Project](https://console.firebase.google.com)
  * [Configure app to use Firebase [Android, iOS]](https://firebase.google.com/docs/flutter/setup#configure_to_use_firebase)
    * 填寫 applicationId、填寫 SHA1 值、下載 google-services.json、新增 Firebase SDK
  
*  [Add FlutterFire plugins](https://firebase.google.com/docs/flutter/setup#add_flutterfire_plugins)
   
* [FlutterFire](https://firebaseopensource.com/projects/flutter/plugins/) 一個清單讓你連結到所有 Flutter 的 Firebase function pub

* [Check List](https://firebase.google.com/support/guides/launch-checklist) 方便你開始引入功能

* [Know the function limits (price)](https://firebase.google.com/pricing) 查看每個功能的限制與價格

  


## 🎮 Crashlytics
* Pub: https://pub.dev/packages/firebase_crashlytics

1. Follow the installation instructions from the link above.
2. Import the plugin in the root of your app.
3. Setup crashlytics and go to firebase console to build connection.

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(MyApp());
}
```
![](D:\Project\Flutter\Flutterpedia\firebase\readme_assets\crashlytics1.jpg)

4. Try to push an error by easily [click the buttons](lib/crashlytics/crash_screen.dart). And the errors can be viewed from firebase console.

![](D:\Project\Flutter\Flutterpedia\firebase\readme_assets\crashlytics2.jpg)

   

## 🎰 Authentication
* Pub: https://pub.dev/packages/firebase_auth
1. Follow the installation instructions from the link above. [auth + googleSignIn]

2. Turn on Authentication providers from firebase console.

3. Implementing with correspond sign in provider.

   * [Email / Password Registration](lib/auth/register_screen.dart)
   * [Email / Password Sign In](lib/auth/email_pwd_sign_in_form.dart)
   * [Anonymously Sign In](lib/auth/anonymously_sign_in.dart)
   * [Google Sign In](lib/auth/google_sign_in.dart)
   * [Phone Sign In](lib/auth/phone_sign_in.dart)
   * [Other ways Sign In](lib/auth/other_sign_in.dart) [Twitter, Facebook, Github ...]

   

## 🎲 Cloud Firestore
* Pub: https://pub.dev/packages/cloud_firestore

## 🎴 Storage
* Pub: https://pub.dev/packages/firebase_storage

## 🃏 Remote Config
* Pub: https://pub.dev/packages/firebase_remote_config

## 🀄 Cloud Messaging
* Pub: https://pub.dev/packages/firebase_messaging

## 🏆 Cloud Functions
* Pub: https://pub.dev/packages/cloud_functions


















