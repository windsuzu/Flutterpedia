import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'hero_detail_screen.dart';

class HeroHomeScreen extends StatefulWidget {
  @override
  _HeroHomeScreenState createState() => _HeroHomeScreenState();
}

class _HeroHomeScreenState extends State<HeroHomeScreen> {
  List<String> imageList = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/500/350',
    'https://picsum.photos/320/340',
    'https://picsum.photos/450/360',
    'https://picsum.photos/600/500',
    'https://picsum.photos/700/350',
    'https://picsum.photos/550/450',
    'https://picsum.photos/320/600',
    'https://picsum.photos/250/700',
    'https://picsum.photos/150/500',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hero Animation'),
        ),
        body: _buildStaggeredGridView());
  }

  Widget _buildStaggeredGridView() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(12),
      crossAxisCount: 4,
      itemCount: imageList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _Tile('${imageList[index]}', index);
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(2);
      },
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.source, this.index);

  final String source;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _heroTransition(context, source),
      child: Hero(
        tag: '#image$index',
        flightShuttleBuilder: (context, animation, direction, from, to) =>
            SingleChildScrollView(
              child: from.widget,
            ),
        child: _buildCardView(),
      ),
    );
  }

  Widget _buildCardView() {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(source),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Vincent Van Gogh',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _heroTransition(BuildContext context, String source) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HeroDetailScreen(source: source, tag: "#image$index")));
  }
}
