import 'package:flutter/material.dart';
import 'dart:math';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Animation'),
      ),
      body: ListView(
        children: <Widget>[
          _buildListTile('Fade Transition', _fadeTransition),
          _buildListTile('Scale Transition', _scaleTransition),
          _buildListTile('Slide Transition', _slideTransition),
          _buildListTile('Rotation Transition', _rotationTransition),
          _buildListTile('Size Transition', _sizeTransition),
        ],
      ),
    );
  }

  void _fadeTransition() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secAnimation) => FadeTransition(
                  opacity: animation,
                  child: SubPage(),
                )));
  }

  void _scaleTransition() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secAnimation) => ScaleTransition(
                  scale: animation,
                  child: SubPage(),
                )));
  }

  void _slideTransition() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secAnimation) => SlideTransition(
                  position: Tween(begin: Offset(1, 0), end: Offset.zero)
                      .animate(animation),
                  child: SubPage(),
                )));
  }

  void _rotationTransition() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secAnimation) =>
                RotationTransition(
                  // 360 degrees = 1
                  turns: Tween<double>(begin: 1, end: 0).animate(animation),
                  child: SubPage(),
                )));
  }

  void _sizeTransition() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secAnimation) => Align(
                  child: SizeTransition(
                    sizeFactor: animation..addListener(() => print(animation)),
                    child: SubPage(),
                  ),
                )));
  }

  Widget _buildListTile(String title, Function onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('SubPage'),
      ),
      body: Center(
        child: Text('sub page'),
      ),
    );
  }
}
