import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityScreen extends StatefulWidget {
  @override
  _ConnectivityScreenState createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    _setupNetworkListener();
    super.initState();
  }

  void _setupNetworkListener() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print(result);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connectivity Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Check Connectivity'),
              onPressed: _checkConnectivity,
              shape: StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  void _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('connected to a mobile network.');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('connected to a wifi network.');
    } else {
      print('no network.');
    }
  }
}
