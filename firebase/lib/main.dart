import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase/crashlytics/crash_screen.dart';
import 'package:firebase/auth/auth_screen.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: ListView(
        children: <Widget>[
          _buildNavigationTile(context, 'Crashlytics', CrashScreen()),
          _buildNavigationTile(context, 'Auth', AuthScreen()),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(
      BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return screen;
          })),
    );
  }
}
