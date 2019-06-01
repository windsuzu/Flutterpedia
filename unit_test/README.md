# About
這裡記錄了學習 Flutter - Dart 如何進行 Unit test 的方法。

More information: <https://flutter.dev/docs/cookbook/testing>

## ⚾ Unit Test

### test functions
* [Basic testing](test/unit_test/basic_test.dart): 一些最基本的語法，expect, contains, start/endsWith 等等

* [Setup testing](test/unit_test/setup_test.dart): 學習怎麼樣在 test 前 setup 一些物件，並在結束時 teardown

* [Asynchronous testing](test/unit_test/async_test.dart): unit test 最重要的部分，如果搭配 Future, Stream, .. 和不一樣的 emit 與 expect 語法來進行測試

* 以上參考官方所提供的[文件](https://github.com/dart-lang/test/blob/master/README.md)

  

### Mockito
* Adding Dependency
``` yaml
dev_dependencies:
  mockito: ^4.0.0
```

* [Mockito testing](test/unit_test/mockito_test.dart)

* [官方文件](https://flutter.dev/docs/cookbook/testing/unit/mocking)

* [Mockito Pub](https://pub.dev/packages/mockito)  

  


## ⚽ Widget Test
* [Basic Widget testing](test/widget_test/widget_test.dart): 在 testWidget 環境下利用 pumpWidget 生成 widget ，並且使用 find 和 expect 查看是否有此元件

* [Finding widget](test/widget_test/finding_widget.dart): Flutter 提供多種方式來查找 widget

* [Interact with widget](test/widget_test/interact_widget.dart): 找到 widget 之後，就可以對該 widget 進行 tap, drag, input 等各種測試

  


## 🏀 Integration Test
* Adding Dependency
``` yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
```

* 在 test_driver 底下建立 test files
  1. [Instrument the app](test_driver/app.dart)
  2. [write the test](test_driver/app_test.dart)

* 設定好手機、模擬器，並執行指令 `flutter drive --target=test_driver/app.dart`
* [官方文件](https://flutter.dev/docs/cookbook/testing/integration/introduction)



## 🎱 CI/CD Tool - CodeMagic
* [Codemagic - CI/CD for Flutter](https://codemagic.io/start/)
* Pros and Cons: [5+5 reasons why Flutter + Codemagic](<https://blog.usejournal.com/5-5-reasons-why-flutter-codemagic-will-own-mobile-application-development-world-1f87367f5a2d>) 
* Tutorial: [Continuous Integration for Flutter with Codemagic](https://medium.com/flawless-app-stories/continuous-integration-for-flutter-with-codemagic-239aa206a70)