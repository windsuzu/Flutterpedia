import 'package:flutter/material.dart';
import 'package:local_storage/shared_preferences/preferences_screen.dart';
import 'package:local_storage/sqflite/sqflite_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Local Storage Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Local Storage Demo'),
            ),
            body: Builder(
              builder: (context) => ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('Shared Preferences'),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PreferencesScreen())),
                      ),
                      ListTile(
                        title: Text('Sqflite'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SqfliteScreen())),
                      )
                    ],
                  ),
            )));
  }
}
