import 'package:flutter/material.dart';

class AnimatedPositionedScreen extends StatefulWidget {
  @override
  _AnimatedPositionedState createState() => _AnimatedPositionedState();
}

class _AnimatedPositionedState extends State<AnimatedPositionedScreen> {
  var _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedPositioned Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changePositioned),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
              child: FlutterLogo(
                size: 200,
              ),
              width: _width(),
              left: _left(),
              top: _top(),
              curve: Curves.easeOutQuad,
              duration: Duration(milliseconds: 600))
        ],
      ),
    );
  }

  double _top()=> _changed ? 100: 30;
  double _left()=> _changed ? 200: 50;
  double _width() => _changed ? 200: 50;
  void _changePositioned() => setState(() => _changed = !_changed);
}
