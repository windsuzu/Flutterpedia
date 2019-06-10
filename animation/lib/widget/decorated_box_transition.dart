import 'package:flutter/material.dart';

// refer: https://api.flutter.dev/flutter/widgets/DecoratedBoxTransition-class.html

class DecoratedBoxTransitionScreen extends StatefulWidget {
  @override
  _DecoratedBoxTransitionState createState() => _DecoratedBoxTransitionState();
}

class _DecoratedBoxTransitionState extends State<DecoratedBoxTransitionScreen>
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
        title: Text('DecoratedBoxTransition Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeDecoratedBox),
      body: Center(
          child: DecoratedBoxTransition(
              decoration: DecorationTween(
                      begin: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(blurRadius: 10, offset: Offset(2, 2))
                          ]),
                      end: BoxDecoration(color: Colors.white))
                  .animate(CurvedAnimation(
                      parent: _controller, curve: Curves.decelerate)),
              child: Container(
                padding: EdgeInsets.all(12),
                child: FlutterLogo(
                  size: 120,
                ),
              ))),
    );
  }

  void _changeDecoratedBox() async {
    await _controller.forward();
    await Future.delayed(Duration(seconds: 1));
    await _controller.reverse();
  }
}
