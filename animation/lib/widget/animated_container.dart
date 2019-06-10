import 'package:flutter/material.dart';

// refer: https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html

class AnimatedContainerScreen extends StatefulWidget {
  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainerScreen> {
  var _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeContainer),
      body: Center(
        child: AnimatedContainer(
            height: _height(),
            width: _width(),
            curve: Curves.elasticOut,
            decoration: _decoration(),
            duration: Duration(milliseconds: 1200)),
      ),
    );
  }

  Decoration _decoration() => _changed
      ? BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(0))
      : BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(100));

  double _width() => _changed ? 300 : 200;

  double _height() => _changed ? 400 : 200;

  void _changeContainer() => setState(() => _changed = !_changed);
}
