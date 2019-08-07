# Utilities

我收集了一些在 Flutter 中常用的 dart 取向工具

## 😺 json_serializable 
> [Good Article: Flutter Json自动反序列化——json_serializable ](https://juejin.im/post/5b5f00e7e51d45190571172f)

除了直接將 json string 利用一些 plugins 轉換成 dart object 外，我們也可以使用 `json_serializable`

1. 我們到 [`pubspec.yaml`](pubspec.yaml) 加入 3 個 dependencies
   * json_annotation
   * build_runner
   * json_serializable

2. 建立 [object class](lib/json/post.dart), 我使用 [JsonPlaceHolder](https://jsonplaceholder.typicode.com/) 作為範例

3. 加入相關 annotation 跟用於 build_runner 的 part 語法
   * `part 'post.g.dart';`
   * `@JsonSerializable()`
   * `@JsonKey` if necessary

4. Run `flutter packages pub run build_runner build` in terminal
   * If not works, consider adding the conflict resolver 
   * `flutter packages pub run build_runner build --delete-conflicting-outputs`

5. 將生成文件 [`post.g.dart`](lib/json/post.g.dart) 中的 private method 貼回給原本的 [object class](lib/json/post.dart).

這樣子就大功告成了，可以用於 shared preferences, http fetching 等地方。

> View Example
> * [Post Object](lib/json/post.dart)
> * [Manipuate with object](lib/json/json_screen.dart)

## 😸 DateTime
> [Good Article: Format DateTime in Flutter](https://androidkt.com/format-datetime-in-flutter/)

我們常要使用 DateTime 作為 timestamp，也會將 DateTime 轉換成 string 顯示或儲存到伺服器。

要處理 DateTime 首先要安裝 `intl` 這個 [dependency](https://pub.dev/packages/intl)

1. setup dependency in [pubsepc.yaml](pubspec.yaml)
2. We have [these methods](lib/date_time_screen.dart)
   * Get Current DateTime
   * Get Specific DateTime
   * Convert DateTime into String
   * Convert String into DateTime
   * Compare DateTime
     * isBefore
     * isAfter
   * Get the Duration between two DateTimes
   * Add some Duration into a DateTime

> View Example
> * [Functions](lib/date_time_screen.dart)