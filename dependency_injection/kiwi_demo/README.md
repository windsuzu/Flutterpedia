# Kiwi Demo

Kiwi 是一個由 [Letsar](https://github.com/letsar) 所寫的 Flutter Dependency injection library

詳細的介紹文章可以參考這裡 [Announcing kiwi](https://medium.com/flutter-community/announcing-kiwi-52ddb3935e6d) 以及 [Github repository](https://github.com/letsar/kiwi)

另外也可以參考上面我照樣照句寫的 Example 😁



## Core Concept

### Container
Kiwi 的核心就是這個 **Container**，所有的 instance, factory, singleton 都會儲存於此

作者保證這個 Container 不管創建幾次都是同一個 instance
```dart
Container container = Container();
```



### Register

首先我們要先將 class 註冊到 Container 裡面，這邊以作者的範例為例
* 註冊 instance
```dart
// Registers a new instance.
container.registerInstance(Sith('Anakin', 'Skywalker'));

// Registers a new instance with a specified name.
container.registerInstance(Sith('Anakin', 'Skywalker'), name: 'DartVader');

// Registers a new instance, with a specified name, and under a supertype.
// By default instances are registered under their type. 
// If you want to register an instance under a supertype, you have to specify both of them.
// In the above example Character is a supertype of Sith.
container.registerInstance<Character, Sith>(Sith('Anakin', 'Skywalker'), name: 'DartVader');
```



* 註冊 factory
```dart
// Registers a new factory.
container.registerFactory((c) => Sith('Anakin', 'Skywalker'));

// Registers a new factory with a specified name.
container.registerFactory((c) => Sith('Anakin', 'Skywalker'), name: 'DartVader');

// Registers a new factory, with a specified name, and under a supertype.
container.registerFactory<Character, Sith>((c) => Sith('Anakin', 'Skywalker'), name: 'DartVader');
```

> 🛑 the c parameter is the instance of the Container



* 註冊 singleton
```dart
// Singletons are registered like factories but they are called only once
// the first time we get their value.

// Registers a new singleton.
container.registerSingleton((c) => Sith('Anakin', 'Skywalker'));

// Registers a new singleton with a specified name.
container.registerSingleton((c) => Sith('Anakin', 'Skywalker'), name: 'DartVader');

// Registers a new singleton, with a specified name, and under a supertype.
container.registerSingleton<Character, Sith>((c) => Sith('Anakin', 'Skywalker'), name: 'DartVader');
```



### Resolving

接下來我們要取得這些儲存在 Container 的東西
```dart
// Gets the instance registered for the Sith type.
Sith theSith = container.resolve<Sith>();

// Gets the instance registered for the Sith type under 'DartVader' name.
Sith dartVader = container.resolve<Sith>('DartVader');

// Container is a callable class, so you can also resolve a type like this:
Sith sith = container<Sith>();
```

剛剛在註冊 factory 和 singleton 的時候，返回的 container instance 在這邊要派上用場了

如果你的 class 有 constructor dependency 時，就可以在裡面使用 `container.resolve`

```dart
class Service {}

class ServiceA extends Service {}

class ServiceB extends Service {
  ServiceB(ServiceA serviceA);
}

...

// Registers a complex factory by resolving the dependency
// when the type is resolved.
container.registerFactory((c) => ServiceB(c.resolve<ServiceA>()));
```



### Generator

因為避免專案中的 dependency 過多造成 boilerplate code 太多

所以作者有製作 code generator 來方便使用

要記得在在專案中加入 `code generator` 的 library 以及 `build_runner`
```yaml
  build_runner: ^1.6.1
  kiwi_generator: ^0.4.0
```



一般的用法如下

```dart
import 'package:kiwi/kiwi.dart';

//  You have to create a part directive.
part 'injector.g.dart'; 

// You have to create an abstract class where all abstract methods 
// are annotated with at least one @Register metadata.
abstract class Injector {
    
  // Registering a singleton for the type ServiceA.
  @Register.singleton(ServiceA) 
  
  // Registering a factory that will create a Service from a ServiceB.
  @Register.factory(Service, from: ServiceB)  
  
  // Registering a factory for ServiceB with the name factoryB.
  @Register.factory(ServiceB, name: 'factoryB') 
  
  // Registering a factory for ServiceC and by specifying to use the factoryB factory for the ServiceB dependency.
  @Register.factory(ServiceC, resolvers: {ServiceB: 'factoryB'})
  
  // Registering a factory for ServiceC, and by specifying to use the ServiceC.other named constructor.
  @Register.factory(ServiceC, constructorName: 'other')
  void configure();
}

void setup() {
  // The call to the generated class to register all the types.
  new _$Injector().configure();
}

class Service {}

class ServiceA extends Service {}

class ServiceB extends Service {
  ServiceB(ServiceA serviceA);
}

class ServiceC extends Service {
  ServiceC(ServiceA serviceA, ServiceB serviceB);
  ServiceC.other(ServiceB serviceA);
}
```



接下來，只要在 terminal 執行 build_runner

```
flutter packages pub run build_runner build
```



就會自動產生以下程式碼

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => ServiceA());
    container
        .registerFactory<Service, ServiceB>((c) => ServiceB(c<ServiceA>()));
    container.registerFactory((c) => ServiceB(c<ServiceA>()), name: 'factoryB');
    container.registerFactory(
        (c) => ServiceC(c<ServiceA>(), c<ServiceB>('factoryB')));
    container.registerFactory((c) => ServiceC.other(c<ServiceB>()));
  }
}
```



我們也可以依需求設置不同的 register methods

```dart
import 'package:kiwi/kiwi.dart';

part 'test01.g.dart';

abstract class Injector {
  @Register.singleton(ServiceA)
  @Register.factory(Service, from: ServiceB)
  @Register.factory(ServiceB, name: 'factoryB')
  @Register.factory(ServiceC, resolvers: {ServiceB: 'factoryB'})
  void common();

  @Register.factory(ServiceC)
  void development();

  @Register.factory(ServiceC, constructorName: 'other')
  void production();
}

void setup(bool isProduction) {
  var injector = _$Injector();
  injector.common();
  if (isProduction) {
    injector.production();
  } else {
    injector.development();
  }
}
```