import 'package:flutter/material.dart';

// refer: https://developer.school/posts/flutter-animated-default-text-style/

class AnimatedDefaultTextStyleScreen extends StatefulWidget {
  @override
  _AnimatedDefaultTextStyleState createState() =>
      _AnimatedDefaultTextStyleState();
}

class _AnimatedDefaultTextStyleState
    extends State<AnimatedDefaultTextStyleScreen> {
  final _txtStyle1 = TextStyle(
      fontSize: 32.0, color: Colors.black, fontWeight: FontWeight.w300);
  final _txtStyle2 = TextStyle(
      fontSize: 64.0, color: Colors.green, fontWeight: FontWeight.bold);
  var _status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedDefaultTextStyle Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeTextStyle),
      body: Center(
          child: AnimatedDefaultTextStyle(
              child: Text('Flutter'),
              curve: Curves.fastOutSlowIn,
              style: _status ? _txtStyle2 : _txtStyle1,
              duration: Duration(milliseconds: 1200))),
    );
  }

  void _changeTextStyle() {
    setState(() {
      _status = !_status;
    });
  }
}
