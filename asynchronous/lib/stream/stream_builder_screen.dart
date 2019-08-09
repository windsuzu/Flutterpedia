import 'package:flutter/material.dart';
 
 
class StreamBuilderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stream Builder Demo'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
    );
  }
}