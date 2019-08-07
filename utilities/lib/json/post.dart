import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  // I want my variable call 'content'
  // But the json key is 'body'
  @JsonKey(name: 'body')
  final String content;

  Post({this.userId, this.id, this.title, this.content});

  // paste convert methods back from generated file
  // * Deserialize
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  // * Serialize
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
