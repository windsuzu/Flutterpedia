import 'package:flutter/material.dart';

class AnimatedPaddingScreen extends StatefulWidget {
  @override
  _AnimatedPaddingState createState() => _AnimatedPaddingState();
}

class _AnimatedPaddingState extends State<AnimatedPaddingScreen> {
  var _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedPadding Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changePadding),
      body: AnimatedPadding(
        padding: _padding(),
        duration: Duration(milliseconds: 1200),
        curve: Curves.fastOutSlowIn,
        child: Container(color: Colors.purple),
      ),
    );
  }

  EdgeInsetsGeometry _padding() => _changed
      ? EdgeInsets.symmetric(vertical: 30, horizontal: 80)
      : EdgeInsets.symmetric(vertical: 100, horizontal: 50);

  void _changePadding() => setState(() => _changed = !_changed);
}
