import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cached Network Image Demo'),
      ),
      body: ListView(
        children: <Widget>[
          _buildCachedNetworkImage("https://picsum.photos/400/200", 200),
          _buildCachedNetworkImage("https://", 200),
        ],
      ),
    );
  }

  Widget _buildCachedNetworkImage(String url, double imageHeight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          );
        },
        placeholder: (context, url) => Container(
            height: imageHeight,
            child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => Container(
            width: double.infinity,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.1),
            ),
            child: Icon(Icons.error)),
      ),
    );
  }
}
