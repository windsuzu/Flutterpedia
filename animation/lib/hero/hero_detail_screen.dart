import 'package:flutter/material.dart';

class HeroDetailScreen extends StatelessWidget {
  final String source;
  final String tag;

  HeroDetailScreen({this.source, this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Hero Detail Screen'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(child: _buildImageView()),
      ),
    );
  }

  Widget _buildImageView() {
    return Hero(
      tag: tag,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(source),
      ),
    );
  }
}
