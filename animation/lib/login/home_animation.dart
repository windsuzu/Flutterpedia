import 'package:flutter/material.dart';

class HomeAnimation {
  final AnimationController controller;

  // Fade 進入 Home Screen 的動畫
  final Animation fadeScreenAnimation;

  // 各個 Widget 跟隨該動畫成長
  final Animation containerGrowAnimation;

  // ListTile 伸展出來的動畫
  final Animation listTileWidthAnimation;

  HomeAnimation(this.controller)
      : fadeScreenAnimation = ColorTween(
                begin: Colors.pink[400], end: Colors.pink[400].withOpacity(0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        containerGrowAnimation = CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.7, curve: Curves.easeOut),
        ),
        listTileWidthAnimation = Tween<double>(begin: 0, end: 64)
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
}

class HomeButtonAnimation {
  final AnimationController controller;

  // 當按下 button 先移到畫面中央
  final Animation buttonBottomCenterAnimation;

  // 一邊放大到佔滿全螢幕
  final Animation buttonZoomOutAnimation;

  HomeButtonAnimation(this.controller)
      : buttonBottomCenterAnimation =
            AlignmentTween(begin: Alignment.bottomRight, end: Alignment.center)
                .animate(CurvedAnimation(
                    parent: controller,
                    curve: Interval(0.0, 0.4, curve: Curves.ease))),
        buttonZoomOutAnimation = Tween<double>(begin: 64, end: 1000)
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
}
