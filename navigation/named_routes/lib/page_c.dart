import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  final String content;

  PageC({this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page C'),
        ),
        body: Center(
          child: Text(
            '$content',
            style: Theme.of(context).textTheme.display1,
          ),
        ));
  }
}
