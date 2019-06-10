import 'package:flutter/material.dart';

class AnimatedSwitcherScreen extends StatefulWidget {
  @override
  _AnimatedSwitcherState createState() => _AnimatedSwitcherState();
}

class _AnimatedSwitcherState extends State<AnimatedSwitcherScreen> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedSwitcher Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeSwitcher),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            // use any transition you want.
            return SlideTransition(
              child: child,
              position: Tween(begin: Offset(0, 10), end: Offset.zero).animate(
                  CurvedAnimation(
                      parent: animation, curve: Curves.elasticInOut)),
            );
          },
          child: Text(
            "$_count",
            // This key causes the AnimatedSwitcher to interpret this as a "new"
            // child each time the count changes, so that it will begin its animation
            // when the count changes.
            key: ValueKey<int>(_count),
            style: TextStyle(
              fontSize: 12 * _count.toDouble(),
            ),
          ),
        ),
      ),
    );
  }

  void _changeSwitcher() => setState(() => _count++);
}
