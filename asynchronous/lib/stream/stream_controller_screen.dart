import 'package:flutter/material.dart';
 
 
class StreamControllerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stream Controller Demo'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
    );
  }
}