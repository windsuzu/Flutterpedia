import 'package:flutter/material.dart';
import 'data.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  VideoCard({Key key, this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: _createShadowRoundedCorners(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: _createThumbnail(),
          ),
          Flexible(
            flex: 2,
            child: _createInfo(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _createShadowRoundedCorners() {
    return BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black26),
        ]);
  }

  Widget _createThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.network(video.thumbnail),
          Positioned(
            bottom: 12,
            right: 12,
            child: _buildPlayButton(),
          )
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return Material(
      color: Colors.black87,
      type: MaterialType.circle,
      child: InkResponse(
        onTap: () async {
          if (await canLaunch(video.url)) {
            await launch(video.url);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Text(
        video.title,
        style: TextStyle(color: Colors.white.withOpacity(0.85)),
      ),
    );
  }
}
