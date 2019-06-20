import 'package:flutter/material.dart';

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Page B'),
        ),
        body: Center(
          child: Text(
            '$args',
            style: Theme.of(context).textTheme.display1,
          ),
        ));
  }
}
