# Asynchronous

Asynchronous in Dart is all by the `Future` and `Stream` classes.

> Great Video Clips from Flutter Team
> * [Isolates and Event Loops - Flutter in Focus](https://www.youtube.com/watch?v=vl_AaCgudcY)
> * [Dart Futures - Flutter in Focus](https://www.youtube.com/watch?v=OTS-ap9_aXc)
> * [Dart Streams - Flutter in Focus](https://www.youtube.com/watch?v=nQBpOIHE4eE)
> * [Async/Await - Flutter in Focus](https://www.youtube.com/watch?v=SmTCmDMi4BY)
> * [Generator Functions - Flutter in Focus](https://www.youtube.com/watch?v=TF-TBsgIErY)

# Future
上網買東西需要花一段時間等待快遞送貨，快遞有可能遺失你的貨，也有可能正確送到你手上。

Future 就像一般的 sync function 一樣，只是會在經過一段時間後才 return 東西給你。

而 return 的東西只有兩種，一種是 success 回傳的物件，一種是 error 的 exception。

就像要使用某個 API 抓取資料時，可能成功的取得資料，也有可能發生連線錯誤取得 error。

[我用了 `Future delayed` 來展示這兩種 Future return 的可能性。](lib\future\future_screen.dart)

## FutureBuilder
我們還可以使用 flutter 提供的 FutureBuilder ，在取得 Future 的同時即時更新 UI 。

這邊我使用 [JSONPlaceHolder](https://jsonplaceholder.typicode.com/) 提供的 API 來[展示 FutureBuilder 的功能](lib\future\future_builder_screen.dart)。

* Future Builder 提供了 snapshot parameter 讓我們可以根據 future 的狀態來決定 UI 要呈現什麼:
  * 在範例裡，我使用 `snapshot.hasData` 來確定已經得到資料，並且展示在 ListView 中
  * `snapshot.hasError` 讓我可以知道發生錯誤，展示錯誤訊息給用戶知道
  * 最後當兩者都不是時，代表資料正在讀取，所以我展示一個 `CircularProgressIndicator` 給用戶


> 一些實用的文章
> [A Guide to Using Futures in Flutter for Beginners](https://medium.com/flutter-community/a-guide-to-using-futures-in-flutter-for-beginners-ebeddfbfb967)
> [Flutter之FutureBuilder的学习和使用](https://juejin.im/post/5bfa9feee51d4524d9250689)

# Stream
今天你連續網購了好幾個東西，貨物將會一一送到你手上，大部分會送到你手上，但順序不一，也有可能發生意外，導致你收不到東西。

Stream 就像 Future 的組合一樣，將會在一段時間內一一的 return object 到你手中，不管是成功或是失敗。
(失敗可能會停止整個 stream 流程，可以透過 `cancelOnError` 調整)

Stream 可以有非常多種方法來決定接收物件流的方式，可以有 periodic、take、listen 等方式，

Stream 也可以決定是 `單一訂閱 (single subscription)` 或 `廣播 (broadcast)` 模式，
(若選用單一訂閱，且又出現兩個人同時 listen 同一個 stream 會發生錯誤)

我們需要配合 StreamSubscription 使用，讓 stream 能夠被 pause, resume, 
還有最重要的 cancel (dispose) 掉，防止 memory leaks。

若是直接使用 stream 來進行 for loop, for each, await loop 時， stream 將無法停止，
必須使用 take, takeWhile 等方式來讓 stream 停止。

[這些我都寫在這個範例當中](lib/stream/stream_screen.dart)。


## StreamController
除了一般的 Stream 以外，我們可以自訂一個 StreamController 來決定要放入什麼東西到 Stream 當中。

我們可以創建一個 StreamController ，使用 add 添加新的物件進入到 stream 。

並且使用 StreamController.stream 來得到每次 add 的物件。

[我將範例寫在這裡](lib/stream/stream_controller_screen.dart)。


## StreamBuilder
跟 Future 提供的 FutureBuilder 一樣，Stream 也有 StreamBuilder 可以即時更新 UI。

* StreamBuilder 的寫法跟 FutureBuilder 幾乎一模一樣，透過 snapshot 來確定 stream 狀態並更新 UI。

[範例在此](lib/stream/stream_builder_screen.dart)。


> 一些實用的文章
> [Understanding Streams in Flutter (Dart)](https://medium.com/flutter-community/understanding-streams-in-flutter-dart-827340437da6)
> [Using Streams in Flutter](https://medium.com/@ayushpguptaapg/using-streams-in-flutter-62fed41662e4)
> [Using StreamBuilder in Flutter](https://medium.com/@sidky/using-streambuilder-in-flutter-dcc2d89c2eae)


# Async / Await
最後，我們可以來學習一下如何讓 asynchronous 的語法變得更簡潔好看。

原本我們在接收 future 的時候，必須使用 `then` 語法來獲得回傳的物件，並用 `catchError` 來攔截錯誤。

``` dart
void getInfo() {
    getToken().then((token) {
      return getInfo(token);
    }).then((info) {
      print(info);
    }).catchError((err) {
      print(err);
    });
}
```

我們可以利用 async / await 的方式來修改，只需在 func 後面加入 async ，並且用 await 來等待每一行的返回後，再繼續下一行。

``` dart
void getInfo() async {
    var token = await getToken();
    var info = await getInfo(token);
    print(info);
}
```

那這樣要怎麼 catchError 呢，只需簡單使用 try / on / catch 就行了 !

``` dart
void getInfo() async {
    try {
        var token = await getToken();
        var info = await getInfo(token);
        print(info);
    } catch (err) {
        print(err);
    }
}
```

> 一些實用的文章
> [Asynchronous programming: futures & async-await](https://dart.dev/tutorials/language/futures)