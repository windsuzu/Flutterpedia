import 'package:flutter/material.dart';
import 'dart:math';

enum GuillotineAnimationStatus { closed, open, animating }

class GuillotineAnimation {
  GuillotineAnimation(this.controller)
      : rotationAnimation = Tween(begin: -pi / 2, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Curves.bounceOut,
                reverseCurve: Curves.bounceIn)),
        fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.5, curve: Curves.ease)));

  final AnimationController controller;
  final Animation<double> rotationAnimation;
  final Animation<double> fadeAnimation;
}
