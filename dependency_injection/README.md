# Dependency Injection

## Motivation

> 利用 Constructor passing dependency 是非常好的方法
>
> 但當 widget 越來越深入 widget tree 底下時，要傳入 dependency 變得非常麻煩

* HomeView
    * MyCustomList
        * PostItem
            * PostMenu
                * PostActions
                    * LikeButton

> 現在 LikeButton 需要 AppInfo 來顯示某些資訊時，
>
> 需要從最頂層開始 passing AppInfo 到 LikeButton
>
> 可以在這裡查看程式碼 [Code](lib/motivation.dart) 



## Solution 1 - Inherited Widget

InheritedWidget 可以讓同個 widget tree 下的 widget 透過 BuildContext 共用 dependency

> Flutter 中已經有很多例子: `Theme` 、 `MediaQuery` ...

實作程式碼在這 [Code](lib/inherited_screen.dart)



## Solution 2 - Provider

Provider 可以說是 InheritedWidget 的加強版，且有非常多特殊的變型，如 StreamProvider, ChangeNotifierProvider, ListenableProvider, ...

Provider 一樣將在 widget tree 頂端注入讓底下 widget 可以共同使用的變數。

實作程式碼在這 [Code](lib/provider_screen.dart)

> 同場加映 StreamProvider: [Code](lib/stream_provider_screen.dart)



## Solution 3 - Kiwi

請參考 [Kiwi Demo](kiwi_demo)