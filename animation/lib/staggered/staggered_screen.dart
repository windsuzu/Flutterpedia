import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:ui';
import 'staggered_animation.dart';
import 'video_card.dart';

class StaggeredScreen extends StatefulWidget {
  @override
  _StaggeredScreenState createState() => _StaggeredScreenState();
}

class _StaggeredScreenState extends State<StaggeredScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  StaggeredAnimation _animation;
  final Artist _artist = FakeData.superfly;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2200),
      vsync: this,
    );
    _animation = StaggeredAnimation(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animation.controller, builder: _buildAnimation),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: _animation.backdropOpacity.value,
          child: Image.asset(
            _artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: _animation.backdropBlur.value,
              sigmaY: _animation.backdropBlur.value),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Transform(
      transform: Matrix4.diagonal3Values(
          _animation.avatarSize.value, _animation.avatarSize.value, 1),
      alignment: Alignment.center,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.white)),
        margin: EdgeInsets.only(top: 32, left: 16),
        padding: EdgeInsets.all(6),
        child: ClipOval(
          child: Image.asset(
            _artist.avatar,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _artist.name,
            style: TextStyle(
                color: Colors.white.withOpacity(_animation.nameOpacity.value),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          Text(
            _artist.location,
            style: TextStyle(
                color:
                    Colors.white.withOpacity(_animation.locationOpacity.value),
                fontWeight: FontWeight.w500),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            width: _animation.dividerWidth.value,
            height: 1.0,
          ),
          Text(
            _artist.biography,
            style: TextStyle(
                color:
                    Colors.white.withOpacity(_animation.biographyOpacity.value),
                height: 1.5),
          )
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return Transform(
      transform: new Matrix4.translationValues(
        _animation.videoScrollerXTranslation.value,
        0.0,
        0.0,
      ),
      child: Opacity(
        opacity: _animation.videoScrollerOpacity.value,
        child: SizedBox.fromSize(
          size: Size.fromHeight(240),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: _artist.videos.length,
              itemBuilder: (context, index) {
                return VideoCard(video: _artist.videos[index]);
              }),
        ),
      ),
    );
  }
}
