import 'package:flutter/material.dart';
import 'package:fluro_demo/fluro/application.dart';
import 'package:fluro/fluro.dart';

final _daysOfWeek = const [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class PageA extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Page A'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Home Page',
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    onPressed: () => _pushToPageB(context),
                    child: Text('Push with passing data'),
                  ),
                  OutlineButton(
                    onPressed: () => _pushToPageC(context),
                    child: Text('Push with custom transition'),
                  ),
                  OutlineButton(
                    onPressed: () => _pushToPageD(context),
                    child: Text('Push and wait for result'),
                  )
                ],
              )
            ],
          ),
        ));
  }

  // Push with passing data
  _pushToPageB(BuildContext context) {
    final message = 'Today is ${_daysOfWeek[new DateTime.now().weekday - 1]}!';
    Application.router.navigateTo(context, "/page_b?message=$message");
  }

  // Push with custom transition
  _pushToPageC(BuildContext context) {
    Application.router.navigateTo(context, '/page_c',
        // this transition will override the transition from router.define !
        transition: TransitionType.custom,
        transitionDuration: Duration(milliseconds: 500),
        transitionBuilder: (context, anim, secAnim, child) {
      return ScaleTransition(
        scale: anim,
        child: RotationTransition(
          turns: anim,
          child: child,
        ),
      );
    });
  }

  // Push and wait for result
  _pushToPageD(BuildContext context) async {
    final result = await Application.router.navigateTo(context, '/page_d');

    if (result != null)
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Result: $result')));
  }
}
