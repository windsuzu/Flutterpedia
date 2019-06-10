import 'package:flutter/material.dart';

class AnimatedOpacityScreen extends StatefulWidget {
  @override
  _AnimatedOpacityState createState() => _AnimatedOpacityState();
}

class _AnimatedOpacityState extends State<AnimatedOpacityScreen> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedOpacity Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeOpacity),
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.fastOutSlowIn,
          opacity: _opacity,
          duration: Duration(milliseconds: 1200),
          child: FlutterLogo(
            size: 200,
            colors: Colors.green,
          ),
        ),
      ),
    );
  }

  void _changeOpacity() {
    setState(() {
      _opacity = (_opacity == 1 ? 0 : 1);
    });
  }
}
