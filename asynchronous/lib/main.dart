import 'package:asynchronous/future/future_builder_screen.dart';
import 'package:asynchronous/future/future_screen.dart';
import 'package:asynchronous/stream/stream_builder_screen.dart';
import 'package:asynchronous/stream/stream_controller_screen.dart';
import 'package:asynchronous/stream/stream_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asynchronous Demo',
      routes: {
        "/future": (_) => FutureScreen(),
        "/future_builder": (_) => FutureBuilderScreen(),
        "/stream": (_) => StreamScreen(),
        "/stream_controller": (_) => StreamControllerScreen(),
        "/stream_builder": (_) => StreamBuilderScreen(),
      },
      home: MyHomePage(title: 'Asynchronous Demo'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: routes
              .map((key, value) {
                return MapEntry(
                    key,
                    ListTile(
                      title: Text(key),
                      onTap: () => Navigator.pushNamed(context, value),
                    ));
              })
              .values
              .toList(),
        ),
      ),
    );
  }
}

var routes = {
  "Future": "/future",
  "Future Builder": "/future_builder",
  "Stream": "/stream",
  "Stream Controller": "/stream_controller",
  "Stream Builder": "/stream_builder",
};
