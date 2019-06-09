import 'package:flutter/material.dart';

class LoginAnimation {
  final AnimationController controller;

  final Animation<double> buttonSqueezeAnimation;
  final Animation<double> buttonZoomout;

  LoginAnimation(this.controller)
      : buttonSqueezeAnimation = Tween<double>(begin: 135, end: 20).animate(
            CurvedAnimation(parent: controller, curve: Interval(0.0, 0.250))),
        buttonZoomout = Tween<double>(begin: 70, end: 1000).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.55, 0.9, curve: Curves.bounceOut)));
}
