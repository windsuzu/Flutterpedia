import 'dart:ui';
import 'package:flutter/material.dart';

class BackdropFilterScreen extends StatefulWidget {
  @override
  _BackdropFilterScreenState createState() => _BackdropFilterScreenState();
}

class _BackdropFilterScreenState extends State<BackdropFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BackdropFilter Demo'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedBackdropFilterWidget(),
              SizedBox(height: 28),
              Text(
                "2. Frosted Effect",
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ),
              Expanded(child: FrostedEffectWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBackdropFilterWidget extends StatefulWidget {
  @override
  _AnimatedBackdropFilterWidgetState createState() =>
      _AnimatedBackdropFilterWidgetState();
}

class _AnimatedBackdropFilterWidgetState
    extends State<AnimatedBackdropFilterWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _sigma;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _sigma = Tween<double>(begin: 0, end: 10).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _changeBlur,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: _sigma.value, sigmaY: _sigma.value),
                child: Container(
                  color: Colors.white.withOpacity(0),
                  child: Text(
                    "1. Blur an image",
                    style: TextStyle(color: Colors.black87, fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeBlur() {
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }
}

class FrostedEffectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        // * add background here first
        Align(
            alignment: Alignment.center,
            child: Image.asset("assets/cat_background.png")),

        // * add blur container with clip and backdrop filter
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

              // * add blur widget in front of your background
              child: Container(
                width: 150,
                height: 100,
                color: Colors.grey.shade200.withOpacity(0.5),
                child: Center(
                    child: Text(
                  "Meow",
                  style: TextStyle(fontSize: 24),
                )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
