import 'package:flutter/material.dart';
import 'inherited_screen.dart';
import 'provider_screen.dart';
import 'stream_provider_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Dependency Injection Demo'),
          ),
          body: Builder(builder: (context) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Inherited Widget'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InheritedScreen())),
                ),
                ListTile(
                  title: Text('Provider'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderScreen())),
                ),
                ListTile(
                  title: Text('Stream Provider'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StreamProviderScreen())),
                ),
              ],
            );
          }),
        ));
  }
}
