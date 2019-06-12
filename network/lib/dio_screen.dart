import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network/post.dart';
import 'dart:convert';

// https://pub.dev/packages/dio

class DioScreen extends StatefulWidget {
  @override
  _DioScreenState createState() => _DioScreenState();
}

class _DioScreenState extends State<DioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dio Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Fetch Json Object through Dio'),
              onPressed: _dioFetchJsonObject,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Fetch Json Array through Dio'),
              onPressed: _dioFetchJsonArray,
              shape: StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  void _dioFetchJsonObject() async {
    var url = 'https://jsonplaceholder.typicode.com/posts/1';
    try {
      Response response = await Dio().get(url);
      final Post post = Post.fromJsonMap(jsonDecode(response.toString()));
      print(post.id);
      print(post.title);
    } catch (e) {
      print(e);
    }
  }

  void _dioFetchJsonArray() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      Response response = await Dio().get(url);
      final String raw = jsonEncode(response.data);
      final List jsonArr = jsonDecode(raw);

      List<Post> postList =
          jsonArr.map((obj) => Post.fromJsonMap(obj)).toList();

      for (var post in postList) {
        print(post.id);
        print(post.title);
      }
    } catch (e) {
      print(e);
    }
  }
}
