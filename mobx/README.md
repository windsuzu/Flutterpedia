# MobX

* [Github](https://github.com/mobxjs/mobx.dart)
* [Tutorial](https://mobx.pub/)
* [Concept](#concept)
* [Example](#example)
* [Guide](#guide-[important])



## Concept

> 以下截取自官方解說

![MobX Triad](https://github.com/mobxjs/mobx.dart/raw/master/docs/src/images/mobx-triad.png)

MobX 的核心為 [Observable](#observable), [Action](#action), [Reaction](#reaction)



## Observable

Observable 代表的是 App 的 `State` ，讓 Observers 觀察並得到更新。

簡單的 Observable 可以定義如下:

```dart 
import 'package:mobx/mobx.dart';

final counter = Observable(0);
```

複雜的 Observable 可以藉由 **[mobx_codegen](https://github.com/mobxjs/mobx.dart/tree/master/mobx_codegen)** package，來定義如下:

```dart
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
```



### Computed Observables

App 的 `state` 又可以分為 `core-state` 和 `derived-state`，例如姓名中的 `firstname` 和 `lastname` 屬於一個人姓名的 core-state，而現在有一個 derived-state 稱為  `fullname` ，即是透過 `firstname` 和 `lastname` 這兩個 core-state 來產生。

```dart
import 'package:mobx/mobx.dart';

part 'contact.g.dart';

class Contact = ContactBase with _$Contact;

abstract class ContactBase with Store {
  @observable
  String firstName;

  @observable
  String lastName;

  @computed
  String get fullName => '$firstName, $lastName';
}
```

> core-state => @observable
>
> derived-state => @computed
>
> fullname 將會隨著 firstname & lastname 的改變而改變。



## Action

Action 則為改變 Observable 的方法，比起直接賦值給 Observable，建立一個帶有語義的 Action 更有意義。

以下為沒有使用 [mobx_codegen](https://github.com/mobxjs/mobx.dart/tree/master/mobx_codegen) 的寫法:

```dart
final counter = Observable(0);

final increment = Action((){
  counter.value++;
});
```

再來是有使用 [mobx_codegen](https://github.com/mobxjs/mobx.dart/tree/master/mobx_codegen) 的寫法:

```dart
abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
```



### Asynchronous Action

mobX.dart 還支援非同步的 Action 而且不用被 [runInAction](https://mobx.pub/api/action#runinaction) 綁定:

```dart
@observable
String stuff = '';

@observable
loading = false;

@action
Future<void> loadStuff() async {
  loading = true; //This notifies observers
  stuff = await fetchStuff();
  loading = false; //This also notifies observers
}
```



## Reaction

Reaction 是 MobX 的最後一角，即為這整個 react-system 的 Observer，當他關注的 Observable 被改變時，將會被通知。

Reaction 有多種不同的版本，但都會返回一個 `ReactionDisposer` 用來 dispose 該 reaction。

> 有一個很棒的 feature 是：reaction 訂閱 observable 不需要什麼繁複的綁定
>
> 簡單的在 reaction 中 reading observable 就足夠了！



##### ReactionDisposer autorun(Function(Reaction) fn)

reaction 將直接執行一次，並且之後在 `fn` 裡的 observables 改變時也會立刻執行。

```dart
import 'package:mobx/mobx.dart';

String greeting = Observable('Hello World');

final dispose = autorun((_) => print(greeting.value));

greeting.value = 'Hello MobX';

// Done with the autorun()
dispose();


// Prints:
// Hello World
// Hello MobX
```



##### ReactionDisposer reaction\<T>(T Function(Reaction) predicate, void Function(T) effect)

只觀察在 `predicate()` 中的 observables，等到他們改變時，便執行 `effect()` 裡的動作。

```dart
import 'package:mobx/mobx.dart';

String greeting = Observable('Hello World');

final dispose = reaction((_) => greeting.value, (msg) => print(msg));

greeting.value = 'Hello MobX'; // Cause a change

// Done with the reaction()
dispose();


// Prints:
// Hello MobX
```



##### ReactionDisposer when(bool Function(Reaction) predicate, void Function() effect)

只觀察在 `predicate()` 中的 observables，等到他們改變且為 `true` 時，便執行 `effect()` 裡的動作。

執行完後會自動 dispose，可以將他視為 **一次性** 的 `reaction`。 也可以在觸發之前就先 dispose 他。

```dart
import 'package:mobx/mobx.dart';

String greeting = Observable('Hello World');

final dispose = when((_) => greeting.value == 'Hello MobX', () => print('Someone greeted MobX'));

greeting.value = 'Hello MobX'; // Causes a change, runs effect and disposes


// Prints:
// Someone greeted MobX
```



##### Future\<void> asyncWhen(bool Function(Reaction) predicate)

相當於 `when` 但是是回傳 `Future`。是一個等待 `predicate()` 變成 `true` 的好方法。

```dart
final completed = Observable(false);

void waitForCompletion() async {
  await asyncWhen(() => _completed.value == true);

  print('Completed');
}
```



### Observer

最能更視覺化 reaction 的即是 UI，所以 **[flutter_mobx](https://github.com/mobxjs/mobx.dart/tree/master/flutter_mobx)** package 提供了 `Observer` widget 作為 Observer 角色訂閱 Observable 的每個改變，並在 builder 中 rebuild 與 rerender 。



底下是一個使用 Observer 的 Counter example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({Key key}) : super(key: key);

  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Observer(
                  builder: (_) => Text(
                        '${_counter.value}',
                        style: const TextStyle(fontSize: 20),
                      )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```



## Example

* [Counter](example/mobx_counter)
* [Form](example/mobx_form)
* [Github Repository](example/mobx_github_repo)
* [Hacker News](example/mobx_hacker_news)
* [Todos](example/mobx_todos)
* [Stream with Provider](example/mobx_stream)
* [Multi Counter](example/mobx_multi_counter)



## Guide [Important]

* [Build Output](https://mobx.pub/guides/output)

* [Organizing Stores](https://mobx.pub/guides/stores)

* [Rules of Reactivity](https://mobx.pub/guides/when-does-mobx-react)