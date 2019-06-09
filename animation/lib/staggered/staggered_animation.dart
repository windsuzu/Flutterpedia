import 'package:flutter/material.dart';

class StaggeredAnimation {
  StaggeredAnimation(this.controller)
      : backdropOpacity = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.500, curve: Curves.ease))),
        backdropBlur = Tween(begin: 0.0, end: 5.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.800, curve: Curves.ease))),
        avatarSize = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.400, curve: Curves.elasticOut))),
        nameOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.350, 0.450, curve: Curves.easeIn))),
        locationOpacity = Tween(begin: 0.0, end: 0.85).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.500, 0.600, curve: Curves.easeIn))),
        dividerWidth = Tween(begin: 0.0, end: 225.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.650, 0.750, curve: Curves.fastOutSlowIn))),
        biographyOpacity = Tween(begin: 0.0, end: 0.85).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.750, 0.900, curve: Curves.easeIn))),
        videoScrollerXTranslation = Tween(begin: 60.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.890, 1.000, curve: Curves.ease))),
        videoScrollerOpacity = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.890, 1.000, curve: Curves.fastOutSlowIn)));

  final AnimationController controller;
  final Animation<double> backdropOpacity;
  final Animation<double> backdropBlur;
  final Animation<double> avatarSize;
  final Animation<double> nameOpacity;
  final Animation<double> locationOpacity;
  final Animation<double> dividerWidth;
  final Animation<double> biographyOpacity;
  final Animation<double> videoScrollerXTranslation;
  final Animation<double> videoScrollerOpacity;
}
