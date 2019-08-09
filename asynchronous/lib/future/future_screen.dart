import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

class FutureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Future Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(16),
                color: Colors.green,
                child: Text(
                  'Get a msg after 3 seconds',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () => _getFutureString().then(showMessage),
              ),
              RaisedButton(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Text(
                  'Get an error after 3 seconds',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () => _getFutureError().catchError(showMessage),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getFutureString() {
    return Future.delayed(Duration(seconds: 3), () {
      return "Hello there !";
    });
  }

  void showMessage(dynamic msg) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(msg.toString()),
    ));
  }

  Future<dynamic> _getFutureError() {
    return Future.delayed(Duration(seconds: 3), () {
      throw Exception("Error happened !");
    });
  }
}
