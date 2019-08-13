import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class InAppNotificationViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In App Notification View Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Overlay In-App Notification View"),
              onPressed: _showOverlayNotificationView,
            ),
            RaisedButton(
              child: Text("Flushbar In-App Notification View"),
              onPressed: () => _showFlushbarNotificationView(context),
            ),
          ],
        ),
      ),
    );
  }

  // ! Need to wrap the root Material App with OverlaySupport widget.
  void _showOverlayNotificationView() {
    showOverlayNotification((context) {
      return Card(
        margin: EdgeInsets.all(4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: Size(40, 40),
              child: ClipOval(
                child: Container(
                  color: Colors.pink,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: Text("Notification"),
            subtitle: Text("Thanks for using our app !"),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => OverlaySupportEntry.of(context).dismiss(),
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 5000));
  }

  void _showFlushbarNotificationView(BuildContext context) {
    Flushbar _flushbar;
    _flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      title: "Notification",
      message: "Thanks for using our app again !",
      duration: Duration(milliseconds: 5000),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      icon: Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      mainButton: FlatButton(
        onPressed: () => _flushbar.dismiss(),
        child: Text(
          "Close",
          style: TextStyle(color: Colors.amber),
        ),
      ),
    )..show(context);
  }
}
