import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:utilities/json/post.dart';
import 'package:http/http.dart' as http;

class JsonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Utilities"),
      ),
      body: Container(
        child: Center(
            child: FutureBuilder<Post>(
                future: getPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${snapshot.data.title}\n\n ${snapshot.data.content}"),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return CircularProgressIndicator();
                })),
      ),
    );
  }

  // * Need to add `http` dependency in pubsepc.yaml
  Future<Post> getPost() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/posts/1");

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}
