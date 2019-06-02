import 'post.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class Api {
  static final Api _instance = Api._internal();
  Client _httpClient;

  Api._internal() {
    if (_httpClient == null) {
      _httpClient = Client();
    }
  }

  factory Api() => _instance;

  Future<List<Post>> fetchPosts(int startIndex, int limit) async {
    final response = await _httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
