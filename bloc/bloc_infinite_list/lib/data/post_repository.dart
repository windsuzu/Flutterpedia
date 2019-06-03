import 'post_provider.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'post.dart';

class PostRepository {
  PostProvider postProvider;

  PostRepository({@required this.postProvider});

  Future<List<Post>> getPosts(int startIndex, int limit) async {
    return await postProvider.fetchPosts(startIndex, limit);
  }
}
