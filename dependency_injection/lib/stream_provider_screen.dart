import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class StreamProviderScreen extends StatefulWidget {
  @override
  _StreamProviderScreenState createState() => _StreamProviderScreenState();
}

class _StreamProviderScreenState extends State<StreamProviderScreen> {
  final controller = StreamController<bool>();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamProvider Example'),
      ),
      body: StreamProvider.value(
        value: controller.stream,
        initialData: false,
        child: HomePage(controller: controller),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final StreamController<bool> controller;

  HomePage({this.controller});

  @override
  Widget build(BuildContext context) {
    bool isLogin = Provider.of<bool>(context);
    return Container(
      color: isLogin ? Colors.green : Colors.grey,
      alignment: Alignment.center,
      child: MaterialButton(
        child: Text(isLogin ? "登出" : "登入"),
        onPressed: () {
          controller.add(!isLogin);
        },
      ),
    );
  }
}
