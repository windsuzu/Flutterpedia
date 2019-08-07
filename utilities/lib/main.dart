import 'package:flutter/material.dart';
import 'package:utilities/datetime/date_time_screen.dart';
import 'package:utilities/json/json_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utilities',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/json": (_) => JsonScreen(),
        "/datetime": (_) => DateTimeScreen(),
      },
      home: MyHomePage(title: 'Utilities Demo'),
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          String routeName = routes.keys.toList()[index];
          String route = routes[routeName];
          return ListTile(
            title: Text("${routes.keys.toList()[index]}"),
            onTap: () => Navigator.pushNamed(context, route),
          );
        },
        itemCount: routes.length,
      ),
    );
  }
}

final Map<String, dynamic> routes = {
  "Json": "/json",
  "DateTime": "/datetime",
};
