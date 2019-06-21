import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page C'),
        ),
        body: Center(
          child: Text(
            'Crazy transition',
            style: Theme.of(context).textTheme.display1,
          ),
        ));
  }
}
