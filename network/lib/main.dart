import 'package:flutter/material.dart';
import 'package:network/json_screen.dart';
import 'package:network/http_screen.dart';
import 'package:network/dio_screen.dart';
import 'package:network/connectivity_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Network Demo',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Network Demo'),
            ),
            body: Builder(builder: (context) {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Json Example'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JsonScreen())),
                  ),
                  ListTile(
                    title: Text('Http Example'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HttpScreen())),
                  ),
                  ListTile(
                    title: Text('Dio Example'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DioScreen())),
                  ),
                  ListTile(
                    title: Text('Connectivity Example'),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConnectivityScreen())),
                  )
                ],
              );
            })));
  }
}
