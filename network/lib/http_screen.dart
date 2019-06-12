import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network/post.dart';
import 'dart:convert';

// https://pub.dev/packages/http

class HttpScreen extends StatefulWidget {
  @override
  _HttpScreenState createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Http Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Fetch Json Object through Http'),
              onPressed: _httpFetchJsonObject,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Fetch Json Array through Http'),
              onPressed: _httpFetchJsonArray,
              shape: StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  void _httpFetchJsonObject() async {
    var url = 'https://jsonplaceholder.typicode.com/posts/1';
    var response = await get(url);

    if (response.statusCode == 200) {
      final Post post = Post.fromJsonMap(jsonDecode(response.body));
      print(post.id);
      print(post.title);
    }
  }

  void _httpFetchJsonArray() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var response = await get(url);

    if (response.statusCode == 200) {
      final List jsonArr = jsonDecode(response.body);

      List<Post> postList =
          jsonArr.map((obj) => Post.fromJsonMap(obj)).toList();

      for (var post in postList) {
        print(post.id);
        print(post.title);
      }
    }
  }
}
