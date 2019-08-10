import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets Demo'),
      ),
      body: Center(
        child: Container(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
