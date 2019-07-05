import 'package:flutter/material.dart';
import 'injector.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'fruit_service.dart';

void main() {
  setupInjector();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiwi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Kiwi Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  kiwi.Container container = kiwi.Container();

  void _buttonPressed() {
    // correspond to  @Register.factory(Fruit, from: Kiwi)
    Fruit fruit = container.resolve<Fruit>();
    print(fruit.description());

    // correspond to @Register.factory(Apple, name: 'apple')
    Apple apple = container.resolve<Apple>('apple');
    print(apple.description());

    // correspond to @Register.singleton(Banana)
    Banana banana = container.resolve<Banana>();
    print(banana.description());

    // correspond to @Register.factory(GrapeAppleJuice, resolvers: {Apple: 'apple', Grape: 'grape'})
    GrapeAppleJuice grapeAppleJuice = container.resolve<GrapeAppleJuice>();
    print(grapeAppleJuice.description());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kiwi Demo',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonPressed,
        tooltip: 'Greeting',
        child: Icon(Icons.room_service),
      ),
    );
  }
}
