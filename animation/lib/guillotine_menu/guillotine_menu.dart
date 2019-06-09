import 'package:flutter/material.dart';
import 'guillotine_animation.dart';
import 'dart:math';

class GuillotineMenu extends StatefulWidget {
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  GuillotineAnimation _animation;
  GuillotineAnimationStatus menuAnimationStatus =
      GuillotineAnimationStatus.closed;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) => _updateAnimationStatus(status));
    _animation = GuillotineAnimation(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.rotate(
            angle: _animation.rotationAnimation.value,
            origin: Offset(24, 56),
            alignment: Alignment.topLeft,
            child: child,
          ),
      child: Material(
        color: Colors.transparent,
        child: Container(
            width: screenWidth,
            height: screenHeight,
            color: Color(0xff333333),
            child: Stack(
              children: <Widget>[
                _buildMenuTitle(screenWidth),
                _buildMenuIcon(),
                _buildMenuContent(),
              ],
            )),
      ),
    );
  }

  void _handleMenuOpenClose() {
    if (menuAnimationStatus == GuillotineAnimationStatus.closed) {
      _controller.forward().orCancel;
    } else if (menuAnimationStatus == GuillotineAnimationStatus.open) {
      _controller.reverse().orCancel;
    }
  }

  void _updateAnimationStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        menuAnimationStatus = GuillotineAnimationStatus.open;
        break;
      case AnimationStatus.dismissed:
        menuAnimationStatus = GuillotineAnimationStatus.closed;
        break;
      default:
        menuAnimationStatus = GuillotineAnimationStatus.animating;
        break;
    }
  }

  Widget _buildMenuTitle(double width) {
    return Positioned(
      top: 32,
      left: 40,
      width: width,
      height: 24,
      child: Transform.rotate(
        alignment: Alignment.topLeft,
        origin: Offset.zero,
        angle: pi / 2.0,
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Opacity(
              opacity: _animation.fadeAnimation.value,
              child: Text(
                "ACTIVITY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuIcon() {
    return Positioned(
      top: 32.0,
      left: 4.0,
      child: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () => _handleMenuOpenClose(),
      ),
    );
  }

  Widget _buildMenuContent() {
    final List<Map> _menus = <Map>[
      {
        "icon": Icons.person,
        "title": "profile",
        "color": Colors.white,
      },
      {
        "icon": Icons.view_agenda,
        "title": "feed",
        "color": Colors.white,
      },
      {
        "icon": Icons.swap_calls,
        "title": "activity",
        "color": Colors.cyan,
      },
      {
        "icon": Icons.settings,
        "title": "settings",
        "color": Colors.white,
      },
    ];
    return Padding(
      padding: EdgeInsets.only(left: 64, top: 96),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _menus.map((item) {
            return ListTile(
              leading: Icon(
                item["icon"],
                color: item["color"],
              ),
              title: Text(
                item["title"],
                style: TextStyle(color: item["color"], fontSize: 24),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
