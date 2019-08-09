import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FutureBuilderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Builder Demo'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text("${snapshot.data[index].title}"),
                          subtitle: Text("${snapshot.data[index].body}"),
                        ),
                      ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

/*
  [{
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
  }, ...
  }]
  */
Future<List<Post>> getPosts() {
  return get("https://jsonplaceholder.typicode.com/posts").then((response) {
    if (response.statusCode == 200) {
      String raw = response.body;
      List<dynamic> jsonList = jsonDecode(raw);
      return jsonList.map((jsonObject) {
        return Post(
          jsonObject["userId"],
          jsonObject["id"],
          jsonObject["title"],
          jsonObject["body"],
        );
      }).toList();
    } else {
      throw Exception("Something went wrong.");
    }
  });
}

class Post {
  final int userId;
  final int postId;
  final String title;
  final String body;

  Post(this.userId, this.postId, this.title, this.body);
}
