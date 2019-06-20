# Navigation

從一些簡單的 push 技巧，到 routes 設置，最後使用 fluro 來控制 App 整體頁面流程。

* [Basics](#basics)
* [Named Route](#named-route)
* [Fluro](#fluro)



## Basics

### Navigate to a new screen and back

* [Cookbook](<https://flutter.dev/docs/cookbook/navigation/navigation-basics>)

如果你想要跳到 Page A 再跳回 Page B 時

在 Page A 使用 push 語法

```dart
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PageB()),
);
```

並在 Page B 使用 pop 語法

```dart
onPressed: () {
  Navigator.pop(context);
}
```



### Send data to a new screen

* [Cookbook](<https://flutter.dev/docs/cookbook/navigation/passing-data>)

當你想要從 Page A 傳送資料到 Page B 來使用時

先定義好 Page B 要接收的資料

```dart
class PageB extends StatelessWidget {
  final String title;

  // In the constructor, require a title.
  PageB({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
```

在 Page A 就可以輕鬆傳過去

```dart
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PageB(title: 'Hello')),
);
```



### Return data from a screen

* [Cookbook](https://flutter.dev/docs/cookbook/navigation/returning-data)

當你想要把 Page B 的某些結果，在返回時一併給 Page A 時

Page A 利用 await 方式等待 Page B 的結果

```dart
final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageB()),
);
```

在 PageB 定義好 pop 的 result 即可

```dart
Navigator.pop(context, 'Here is my result');
```

最後就可以在 Page A 使用該 result



## Named Route

* [Cookbook](https://flutter.dev/docs/cookbook/navigation/named-routes)

如果你在建構大專案時，有非常多的 page 需要 navigate，你可以使用內建的 named route 方法，來避免太多的 push code duplication。

建立好 named route 後，只要使用 `Navigator.pushNamed()` 就可以快速跳轉到定義好的頁面。



### 首先在 MaterialApp 定義好 routes

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => PageA(),
    '/pageb': (context) => PageB(),
    '/pagec': (context) => PageC(),
  },
);
```

> ❗ 要注意的是，一但定義好 initialRoute 的頁面，就不需要在定義 home 了 ❗



接著在 app 的任何地方，只要使用 pushNamed 即可移動到定義好的 page

```dart
Navigator.pushNamed(context, '/pageb');
```



### 在 named route 情況下傳送資料

#### 方法 1

在 Page B 指定要接收的資料類型，使用 `ModalRoute.of().settings.arguments` 來取得。

> 在這個例子中，String 可以取代成任何你想傳的類型。

```dart
@override
Widget build(BuildContext context) {
  // Extract the arguments from the current ModalRoute settings and cast them
  final String args = ModalRoute.of(context).settings.arguments;

  return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Center(
        child: Text(
          '$args',
          style: Theme.of(context).textTheme.display1,
        ),
      ));
}
```

Page A 即可使用 pushNamed 給予的 arguments 來指定傳送資料

```dart
String args = 'Extract';
Navigator.pushNamed(context, '/pageb', arguments: args);
```




#### 方法 2

利用常態方式接收 arguments，不在此使用 `ModalRoute` 來取得值

```dart
class PageC extends StatelessWidget {
  final String content;
  
  PageC({this.content});
  
  ...
}
```

而是在 MaterialApp 先定義好 `onGenerateRoute`，並以此來指定當 push 時傳送資料

```dart
onGenerateRoute: (settings) {
   if (settings.name == '/pagec') {
     final String args = settings.arguments;
     return MaterialPageRoute(
         builder: (context) => PageC(
               content: args,
             ));
   }
}
```

同樣方式傳送即可

```dart
String args = 'Pass';
Navigator.pushNamed(context, '/pagec', arguments: args);
```



* [My Example Code](named_routes)



## Fluro

* Github: https://github.com/theyakka/fluro

Fluro 是一個管理 route 以及便利化 navigation 的 third library ，不但支援內建 routes 外，還有各式各樣易使用的 function。









* [My Example Code](fluro_demo)