import 'package:flutter/material.dart';
import 'dart:convert';
import 'post.dart';

String json = """
    {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam ostrum rerum est autem sunt rem eveniet architecto"
  }
    """;

String jsonArray = """
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iure voluptatem occaecati omnis eligendi aut ad voluptatem doloribus vel accusantium quis pariatur molestiae porro eius odio et labore et velit aut"
  }
  ]
    """;

class JsonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Json Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Decode Json Object'),
              onPressed: _decodeJsonObject,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Decode Json Array'),
              onPressed: _decodeJsonArray,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Decode Json Using Model'),
              onPressed: _decodeJsonObjectWithModel,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Decode JsonArray Using Model'),
              onPressed: _decodeJsonArrayWithModel,
              shape: StadiumBorder(side: BorderSide()),
            )
          ],
        ),
      ),
    );
  }

  _decodeJsonObject() {
    print("userId: ${jsonDecode(json)['userId']}");
    print("title: ${jsonDecode(json)['title']}");
  }

  _decodeJsonArray() {
    List arr = jsonDecode(jsonArray);

    arr.forEach((obj) {
      print(obj['id']);
      print(obj['title']);
    });
  }

  _decodeJsonObjectWithModel() {
    Post post = Post.fromJsonMap(jsonDecode(json));
    print(post.id);
    print(post.title);
  }

  _decodeJsonArrayWithModel() {
    List jsonArr = jsonDecode(jsonArray);
    List postArr = jsonArr.map((json) => Post.fromJsonMap(json)).toList();

    for (var post in postArr) {
      print(post.id);
      print(post.title);
    }
  }
}
