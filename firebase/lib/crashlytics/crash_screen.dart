import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crashlytics Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                child: const Text('Key'),
                onPressed: () {
                  Crashlytics.instance.setString('foo', 'bar');
                }),
            FlatButton(
                child: const Text('Log'),
                onPressed: () {
                  Crashlytics.instance.log('baz');
                }),
            FlatButton(
                child: const Text('Crash'),
                onPressed: () {
                  // Use Crashlytics to throw an error. Use this for
                  // confirmation that errors are being correctly reported.
                  Crashlytics.instance.crash();
                }),
            FlatButton(
                child: const Text('Throw Error'),
                onPressed: () {
                  // Example of thrown error, it will be caught and sent to
                  // Crashlytics.
                  throw StateError('Uncaught error thrown by app.');
                }),
          ],
        ),
      ),
    );
  }
}
