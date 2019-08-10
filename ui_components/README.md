# UI Components

這裡收集了一些在專案上常用以及不容易掌握的 UI 元件。

一些是 flutter sdk 內建的元件，一些是有名的 third party library


## Assets
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

[完整 code 在這裡](lib/assets_screen.dart)。


## AutoSizeText


## BackdropFilter


## Clip


## Image


## Ink


## Offline