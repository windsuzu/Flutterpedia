import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Share this app.'),
              onPressed: _shareApp,
              shape: StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  void _shareApp() {
    Share.share('Check out my app: https://github.com/windsuzu/Flutterpedia');
  }
}
