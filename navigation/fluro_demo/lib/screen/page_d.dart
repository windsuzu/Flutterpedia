import 'package:flutter/material.dart';

class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page D'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pass Result back',
                style: Theme.of(context).textTheme.display1,
              ),
              OutlineButton(
                onPressed: () => _passResultBack(context),
                child: Text('Pass `hello` back'),
              ),
            ],
          ),
        ));
  }

  _passResultBack(BuildContext context) {
    Navigator.pop(context, 'hello');
  }
}
