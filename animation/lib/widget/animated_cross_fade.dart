import 'package:flutter/material.dart';

// refer: https://api.flutter.dev/flutter/widgets/AnimatedCrossFade-class.html

class AnimatedCrossFadeScreen extends StatefulWidget {
  @override
  _AnimatedCrossFadeState createState() => _AnimatedCrossFadeState();
}

class _AnimatedCrossFadeState extends State<AnimatedCrossFadeScreen> {
  bool firstStateEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedCrossFade Example'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: _changeCrossFade),
      body: Center(
        child: AnimatedCrossFade(
            firstChild: _buildBeforeWidget(),
            secondChild: _buildAfterWidget(),
            crossFadeState: firstStateEnabled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 1500)),
      ),
    );
  }

  void _changeCrossFade() {
    firstStateEnabled = !firstStateEnabled;
    setState(() {});
  }

  Widget _buildBeforeWidget() {
    return Container(
      height: 200,
      width: 200,
      child: FlutterLogo(
        colors: Colors.green,
      ),
    );
  }

  Widget _buildAfterWidget() {
    return Container(
      height: 200,
      width: 200,
      child: FlutterLogo(
        colors: Colors.red,
      ),
    );
  }
}
