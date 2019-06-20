import 'package:flutter/material.dart';

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    onPressed: () => _pushWithExtractArgumentsToPageB(context),
                    child: Text('Push to Page B'),
                  ),
                  OutlineButton(
                    onPressed: () => _pushWithPassArgumentsToPageC(context),
                    child: Text('Push to Page C'),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _pushWithExtractArgumentsToPageB(BuildContext context) {
    String args = 'Extract';
    Navigator.pushNamed(context, '/pageb', arguments: args);
  }

  void _pushWithPassArgumentsToPageC(BuildContext context) {
    String args = 'Pass';
    Navigator.pushNamed(context, '/pagec', arguments: args);
  }
}
