
# About
這裡記錄了學習 Flutter - Dart 如何進行 Unit test 的方法。

More information: <https://flutter.dev/docs/cookbook/testing>

## Unit Test

### 🎈test functions

* [Basic testing](test/basic_test.dart): 一些最基本的語法，expect, contains, start/endsWith 等等
* [Setup testing](test/setup_test.dart): 學習怎麼樣在 test 前 setup 一些物件，並在結束時 teardown
* [Asynchronous testing](test/async_test.dart): unit test 最重要的部分，如果搭配 Future, Stream, .. 和不一樣的 emit 與 expect 語法來進行測試
* 以上參考官方所提供的[文件](https://github.com/dart-lang/test/blob/master/README.md)



### 🎄Mockito
* [Adding Dependency](pubspec.yaml)
* [Mockito testing](test/mockito_test.dart)
* [官方文件](https://flutter.dev/docs/cookbook/testing/unit/mocking)
* [Pub for more example](https://pub.dev/packages/mockito)



# Widget Test



# Integration Test

