import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StreamBuilderScreen extends StatefulWidget {
  @override
  _StreamBuilderScreenState createState() => _StreamBuilderScreenState();
}

class _StreamBuilderScreenState extends State<StreamBuilderScreen> {
  StreamController<String> _controller;
  Stream<String> _streamTimes;

  @override
  void initState() {
    _streamTimes = Stream.periodic(Duration(seconds: 1),
        (_) => DateFormat("yy/MM/dd HH:mm:ss").format(DateTime.now()));

    _controller = StreamController<String>();
    _controller.addStream(_streamTimes);
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
        title: Text('Stream Builder Demo'),
      ),
      body: StreamBuilder<String>(
          stream: _controller.stream,
          initialData: "",
          builder: (context, snapshot) {
            if (snapshot.data.isEmpty)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(fontSize: 36, color: Colors.blue),
                ),
              );
            if (snapshot.hasData)
              return Center(
                child: Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 36, color: Colors.blue),
                ),
              );

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
