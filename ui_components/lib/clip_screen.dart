import 'package:flutter/material.dart';
import 'dart:math';

class ClipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Clip Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildClipOvalImage(),
                SizedBox(height: 12),
                _buildClipRectImage(),
                SizedBox(height: 12),
                _buildClipRRectImage(),
                SizedBox(height: 12),
                _buildClipPathImage(),
              ],
            ),
          ),
        ));
  }

  Widget _buildClipOvalImage() {
    return ClipOval(child: SizedBox(width: 150, height: 150, child: image()));
  }

  // * ClipRect 一定 ipad Clipper
  Widget _buildClipRectImage() {
    return ClipRect(
      clipper: MyClipper(),
      child: SizedBox(width: 150, height: 150, child: image()),
    );
  }

  Widget _buildClipRRectImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        width: 150,
        height: 150,
        child: image(),
      ),
    );
  }

  Widget _buildClipPathImage() {
    return ClipPath(
      clipper: StarClipper(80),
      child: SizedBox(width: 150, height: 150, child: image()),
    );
  }

  Widget image() => Image.asset(
        "assets/dog_image.jpeg",
        fit: BoxFit.cover,
      );
}

// * This clipper remove the every sides by 30
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(30, 30, size.width - 30, size.height - 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

// * This clipper will crop a image into a star shape
class StarClipper extends CustomClipper<Path> {
  final double radius;

  StarClipper(this.radius);

  @override
  Path getClip(Size size) {
    double radius = this.radius;
    Path path = new Path();
    double radian = degree2Radian(36); // 36为五角星的角度
    double radiusIn = (radius * sin(radian / 2) / cos(radian)); // 中间五边形的半径

    path.moveTo((radius * cos(radian / 2)), 0.0); // 此点为多边形的起点
    path.lineTo((radius * cos(radian / 2) + radiusIn * sin(radian)),
        (radius - radius * sin(radian / 2)));
    path.lineTo(
        (radius * cos(radian / 2) * 2), (radius - radius * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) + radiusIn * cos(radian / 2)),
        (radius + radiusIn * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) + radius * sin(radian)),
        (radius + radius * cos(radian)));
    path.lineTo((radius * cos(radian / 2)), (radius + radiusIn));
    path.lineTo((radius * cos(radian / 2) - radius * sin(radian)),
        (radius + radius * cos(radian)));
    path.lineTo((radius * cos(radian / 2) - radiusIn * cos(radian / 2)),
        (radius + radiusIn * sin(radian / 2)));
    path.lineTo(0.0, (radius - radius * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) - radiusIn * sin(radian)),
        (radius - radius * sin(radian / 2)));

    path.close(); // 使这些点构成封闭的多边形

    return path;
  }

  @override
  bool shouldReclip(StarClipper oldClipper) {
    return this.radius != oldClipper.radius;
  }

  double degree2Radian(int degree) {
    return (pi * degree / 180);
  }
}
