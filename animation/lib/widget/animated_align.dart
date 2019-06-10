import 'package:flutter/material.dart';

class AnimatedAlignScreen extends StatefulWidget {
  @override
  _AnimatedAlignState createState() => _AnimatedAlignState();
}

class _AnimatedAlignState extends State<AnimatedAlignScreen> {
  var _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedAlign Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeAlign),
      body: AnimatedAlign(
        alignment: _align(),
        duration: Duration(milliseconds: 600),
        curve: Curves.slowMiddle,
        child: FlutterLogo(
          size: 200,
          colors: Colors.pink,
        ),
      ),
    );
  }

  Alignment _align() => _changed ? Alignment.bottomLeft : Alignment.topRight;

  void _changeAlign() => setState(() => _changed = !_changed);
}
