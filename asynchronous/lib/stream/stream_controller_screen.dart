import 'dart:async';

import 'package:flutter/material.dart';

class StreamControllerScreen extends StatefulWidget {
  @override
  _StreamControllerScreenState createState() => _StreamControllerScreenState();
}

class _StreamControllerScreenState extends State<StreamControllerScreen> {
  final StreamController<int> _controller = StreamController();

  int counter = 1;
  String displayData = "0";

  @override
  void initState() {
    _controller.stream.listen((data) {
      setState(() {
        displayData += ", $data";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Controller Demo'),
      ),
      body: GestureDetector(
        onTap: _increaseData,
        child: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.transparent,
            child: Center(
              child: Text(
                '$displayData',
                style: TextStyle(color: Colors.green, fontSize: 24),
              ),
            )),
      ),
    );
  }

  void _increaseData() {
    _controller.add(counter++);
  }
}
