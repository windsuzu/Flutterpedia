# BLoC Design

Bloc Design Study: https://felangel.github.io/bloc/

#### The Introduction is divided into 3 parts:

* [Core Concept](#core-concept)
* [Architecture](#architecture)
* [Testing](#testing)

#### The practices:

* [Counter](bloc_counter)
* [Timer](bloc_timer)
* [Infinite List](bloc_infinite_list)
* [Login](bloc_login)
* [Weather](bloc_weather)
* [Todos](bloc_todos)
* [Firebase Login](bloc_firebase_login)
* [BlocListener](bloc_listener)



## Core Concept


### Events
> Events 作為 Bloc 的輸入，通常在 user 跟 UI 互動時 (click button) 被 dispatch。

``` dart
enum CounterEvent { increment, decrement }
```



### States

> States 則是 Bloc 的輸出，同時也作為 App 在某個時間點的狀態。
>
> UI 可以根據 state 的變化來重新渲染。

```
In the counter app, the state is a int: `counter`
```



### Transitions

> state 之間的轉換稱為 transition，transition 會包含 `current state`, `event`, `next state`。

```dart
{
  "currentState": 0,
  "event": "CounterEvent.increment",
  "nextState": 1
}
```



### Streams

> Stream 指的是一連串非同步的資料流。
>
> 就像水管一樣，會有注入水的入口，和噴出水的出口。

```dart
// 用 Stream 方式將 loop 的值，在非同步情況下以 async* + yield 注入
Stream<int> countStream(int max) async* {
    for (int i = 0; i < max; i++) {
        yield i;
    }
}
```

```dart
// 這邊就是水管的出口，使用 async + await 來得到輸出的值
Future<int> sumStream(Stream<int> stream) async {
    int sum = 0;
    await for (int value in stream) {
        sum += value;
    }
    return sum;
}
```



### Blocs

> Bloc (Business Logic Component) 即是透過 Stream 流中的 Events 轉換 States 的大腦。
>
> 每個 bloc 都要有初始的狀態 (`initialState`)，
>
> 根據 event 的輸入轉為不同的、新的 state (`mapEventToState`)。

```dart
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  // 初始狀態設定
  @override
  int get initialState => 0;

  // 每個 bloc 都有的 function，透過 event 轉換 state 
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}
```

之後即可透過 dispatch 的方式將 event 傳入 bloc，來改變 state。

```dart
void main() {
    CounterBloc bloc = CounterBloc();

    for (int i = 0; i < 3; i++) {
        bloc.dispatch(CounterEvent.increment);
    }
}
```

若想在 debug 時，看到 bloc 中間的邏輯運作，如

```dart
{
    "currentState": 0,
    "event": "CounterEvent.increment",
    "nextState": 1
}
{
    "currentState": 1,
    "event": "CounterEvent.increment",
    "nextState": 2
}
{
    "currentState": 2,
    "event": "CounterEvent.increment",
    "nextState": 3
}
```

我們可以添加 BlocDelegate 到 Project 根部，添加 onTransition, onError 控制全部的 bloc 。



### BlocDelegate

可以在 onEvent, onTransition, onError 當中加入一些第三方庫 (Crashlytics, Firebase, ... ) 的偵錯邏輯。

```dart
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
  }
}
```

```dart
void main() {
    // 將 BlocSupervisor 加入在 App 頂端，他是一個可以管理所有 bloc 的 singleton object.
    BlocSupervisor.delegate = SimpleBlocDelegate(); 
    CounterBloc bloc = CounterBloc();

    for (int i = 0; i < 3; i++) {
        bloc.dispatch(CounterEvent.increment);
    }
}
```



## Architecture

![](D:\Project\Flutter\Flutterpedia\bloc\assets\bloc_architecture.png)

運用 Bloc 讓我們可以把 App 設計成三大部分:

* [Data (Data Provider + Repository)](#data)

* [Business Logic](#bloc)
* [Presentation](#presentation)



### Data

> 資料層幫我們跟後台抓取及回傳 raw data，與資料庫協作、網路處理、各種非同步運作

#### Data Provider

> Data Provider 的工作就是跟 raw data 相關的所有 CRUD 工作，例如 `createData`, `readData`, `updateData`, and `deleteData` 等等

```dart
class DataProvider {
    Future<RawData> readData() async {
        // Read from DB or make network request etc...
    }
}
```

> 😛 這邊可以跟 Dio, Firebase 搭配

#### Repository

> Repository 則是 Data Provider 的集中處，幫助我們更有效處理 Data Provider (Facade 設計原則)

```dart
class Repository {
    final DataProviderA dataProviderA;
    final DataProviderB dataProviderB;

    Future<Data> getAllDataThatMeetsRequirements() async {
        final RawDataA dataSetA = await dataProviderA.readData();
        final RawDataB dataSetB = await dataProviderB.readData();

        final Data filteredData = _filterData(dataSetA, dataSetB);
        return filteredData;
    }
}
```

> 😛 可以考慮使用 Factory, Singleton 等設計技術



### BLoC

> Bloc (business logic layer) 將吃下 Presentation 的 event，並生出新的 state
>
> Bloc 可以依賴多個 repositories 以取得 data 

```dart
class BusinessLogicComponent extends Bloc {
    final Repository repository;

    Stream mapEventToState(event) async* {
        if (event is AppStarted) {
            yield await repository.getAllDataThatMeetsRequirements();
        }
    }
}
```

#### Bloc-to-Bloc

> Bloc 之間也可以互相訂閱 stream 流，因其他 Bloc 的改變而改變

```dart
class MyBloc extends Bloc {
  final OtherBloc otherBloc;
  StreamSubscription otherBlocSubscription;

  MyBloc(this.otherBloc) {
    otherBlocSubscription = otherBloc.state.listen((state) {
        // React to state changes here.
        // Dispatch events here to trigger changes in MyBloc.
    });
  }

  @override
  void dispose() {
    // 記得在 dispose 時註銷訂閱
    otherBlocSubscription.cancel();
    super.dispose();
  }
}
```



### Presentation

> Presentation layer 的責任就是根據一至多個 bloc state 來渲染自身
>
> 負責掌握 user input 和 application lifecycle events.

```dart
class PresentationComponent {
    final Bloc bloc;

    PresentationComponent() {
        bloc.dispatch(AppStarted());
    }

    build() {
        // render UI based on bloc state
    }
}
```



## Testing

> Bloc 就是為了最簡化 test 而誕生，能不 test 嗎 ?

我們以 CounterBloc 為例，來測試一下

```dart
enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}
```

想知道更多 unit test 相關內容可以參考 [Unit test](../unit_test) 的部分。

> 首先先在測試前建立好 CounterBloc 的物件

```dart
group('CounterBloc', () {
	CounterBloc counterBloc;
	
	setUp(() {
		counterBloc = CounterBloc();
	});
});
```


> 接著測試 CounterBloc 的初始狀態是否正確為 0

```dart
test('initial state is 0', () {
	expect(counterBloc.initialState, 0);
});
```


> 測試收到 increment 的 event 之後，狀態是否從 0 變成 1

```dart
test('single Increment event updates state to 1', () {
    final List<int> expected = [0, 1];

    expectLater(
        counterBloc.state,
        emitsInOrder(expected),
    );

    counterBloc.dispatch(CounterEvent.increment);
});
```

> 最後，收到 decrement 的 event 之後，狀態是否從 0 變成 -1

```dart
test('single Decrement event updates state to -1', () {
    final List<int> expected = [0, -1];

    expectLater(
        counterBloc.state,
        emitsInOrder(expected),
    );

    counterBloc.dispatch(CounterEvent.decrement);
});
```

> 所有的測試應該會順利通過 !

