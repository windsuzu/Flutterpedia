import 'package:flutter/material.dart';

class PageB extends StatelessWidget {
  final String message;
  PageB({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page B'),
        ),
        body: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.display1,
          ),
        ));
  }
}
