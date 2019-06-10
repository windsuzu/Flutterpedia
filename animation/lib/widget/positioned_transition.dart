import 'package:flutter/material.dart';

class PositionedTransitionScreen extends StatefulWidget {
  @override
  _PositionedTransitionState createState() => _PositionedTransitionState();
}

class _PositionedTransitionState extends State<PositionedTransitionScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PositionedTransition Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changePosition),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
                end: RelativeRect.fromLTRB(120.0, 200.0, 120.0, 0.0),
              ).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.elasticInOut)),
              child: Container(
                padding: EdgeInsets.all(12),
                child: FlutterLogo(
                  size: 50,
                ),
              ))
        ],
      ),
    );
  }

  void _changePosition() async {
    await _controller.forward();
    await Future.delayed(Duration(seconds: 1));
    await _controller.reverse();
  }
}
