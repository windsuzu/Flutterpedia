# UI Components

這裡收集了一些在專案上常用以及不容易掌握的 UI 元件。

一些是 flutter sdk 內建的元件，一些是有名的 third party library


## 🎎 Assets
> [Assets Documentation](https://flutter.dev/docs/development/ui/assets-and-images)

我們都知道要怎麼樣載入 asset 並且 load 出來。

這邊在意的是，當你的 image 有 1x, 2x, 3x 等不同 size 時，要怎麼導入這些圖片。

很簡單，我們只要在存放圖片的資料夾，分別新增 2.0x 和 3.0x 的資料夾

把三張不同大小的圖片，以**相同**的名字分別存在 root, 2.0x, 3.0x 的資料夾即可

``` yaml
.../assets/image.png
.../assets/2.0x/image.png
.../assets/3.0x/image.png
```

並且更新 [pubspec.yaml](pubspec.yaml) 中的 assets

接著只要讀取 1x 的圖片，flutter 就會自動根據 resolution 顯示對應 size 的圖片

``` dart
Image.asset("assets/image.png")
```

> [Full code](lib/assets_screen.dart)


## 🕶 AutoSizeText
> This is a useful third party library: [Pub](https://pub.dev/packages/auto_size_text)

AutoSizeText 用法與一般的 Text 幾乎一樣，只要指定好 maxLines, minFontSize 等 properties，就會自動幫你縮小文字。

* maxLines: 指定文字縮小至最多 n 行
* minFontSize: 文字最小會縮小到指定 size
* overflowReplacement: 當文字縮小到無法再顯示時，以該文字取代

還有更多實用方法如 stepGranularity, 搭配 RichText 等，詳細請看 Pub 中的用法教學

> [Full code](lib/auto_size_text_screen.dart)

## 🎞 BackdropFilter
> [Useful intro video](https://www.youtube.com/watch?v=dYRs7Q1vfYI) by flutter team.

當你想要對 Image 使用 blur 等 effect 時，可以使用 ImageFilter property with BackdropFilter Widget. 

BackdropFilter 將會需要 imageFilter 與 child 來讓 child 得到圖片效果

在範例中，我實現一個將整個圖片套用 blur effect 的方法，以及一個在 iOS 常見的 Frosted Effect.

> [Full code](lib/backdrop_filter_screen.dart)

## 🖼 Cached Network Image
> Pub: https://pub.dev/packages/cached_network_image

Cached Network Image 是一個很棒的 third party library，幫助下載 image、cache image、
並且展示 image 、 placeholder 以及 error image

用法就跟 Pub 寫的一樣

在範例中，我示範了一個讀取圖片時正確的結果，以及一個失敗的結果。還有如何使用 imageBuilder 來編輯圖片，以及使用 placeHolder widget 與 error widget

> [Full code](lib/cached_network_image_screen.dart)

## 🎫 Clip
> Useful articles:
> * [Clipping in Flutter](https://medium.com/flutter-community/clipping-in-flutter-e9eaa6b1721a)
> * [flutter使用剪裁制作评分控件](https://segmentfault.com/a/1190000015149101)
> * [clippy_flutter](https://github.com/figengungor/clippy_flutter)

剪裁遮罩在 flutter 用 clip 來實現，裁切的形狀從一般常用的圓形 (ClipOval), 矩形 (ClipRect), 圓角矩形 (ClipRRect), 
到隨意地變換圖形 (ClipPath)

實際操作非常簡單，都在底下範例裡面

> [Full code](lib/clip_screen.dart)


## 🎊 In-app Notification view
> * [In-App notifications in Flutter](https://medium.com/flutter-community/in-app-notifications-in-flutter-9c1e92ea10b3)
> * [AndreHaueisen / flushbar](https://github.com/AndreHaueisen/flushbar)

當我要展示用戶還在 App 時發生的推播，我參考第一個連結以 [overlay_support](https://pub.dev/packages/overlay_support) 製作 notification view 顯示，也可以使用 flushbar 這個很棒的開源 UI 

在範例中我用了兩種方式製作 in-app notification，可以透過 click button 來模擬推播的狀況

> [Full code](lib/in_app_notification_view_screen.dart)

## 🎇 Ink
> [Ink Documentation](https://api.flutter.dev/flutter/material/Ink-class.html)

Ink 可以實現在 Android material design 裡的 ripple effect.

但常常會出現 ripple 沒有出現的問題，或是圖片蓋過 ripple 的問題

所以記錄兩種問題的解決方法在範例中，以便未來使用

> [Full code](lib/ink_screen.dart)


## 🎗 Offline
> Pub: https://pub.dev/packages/flutter_offline

一個實用的 third party library，能夠快速的讓我們自定義有無網路時的畫面



> [Full code](lib/offline_screen.dart)

## 🎏 Wave
> Pub: https://pub.dev/packages/wave

很潮的 UI 介面，不管是裝逼用還是用來顯示 loading progress 都可以。 

> [Full code](lib/wave_screen.dart)