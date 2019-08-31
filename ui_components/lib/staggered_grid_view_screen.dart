import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewScreen extends StatefulWidget {
  @override
  _StaggeredGridViewScreenState createState() =>
      _StaggeredGridViewScreenState();
}

class _StaggeredGridViewScreenState extends State<StaggeredGridViewScreen>
    with SingleTickerProviderStateMixin {
  List tabs = ["Fixed height", "Dynamic height"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staggered GridView Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildFixedHeightStaggeredGridView(),
          _buildDynamicHeightStaggeredGridView(),
        ],
      ),
    );
  }

  // * I want to create a gridView with layout:
  // * 1 1 2
  // * 3   1   (smaller height)
  // * 4       (bigger height)
  // * 1 1 1 1
  Widget _buildFixedHeightStaggeredGridView() {
    final tiles = [
      buildTextTiles("1"),
      buildTextTiles("2"),
      buildTextTiles("3"),
      buildTextTiles("4"),
      buildTextTiles("5"),
      buildTextTiles("6"),
      buildTextTiles("7"),
      buildTextTiles("8"),
      buildTextTiles("9"),
      buildTextTiles("10"),
    ];

    final staggeredTiles = [
      StaggeredTile.count(1, 1),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(2, 1),
      StaggeredTile.count(3, 0.5),
      StaggeredTile.count(1, 0.5),
      StaggeredTile.count(4, 2),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(1, 1),
    ];

    return StaggeredGridView.count(
      crossAxisCount: 4, // ! All staggered tiles will follow this structure.
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: EdgeInsets.all(8.0),
      children: tiles,
      staggeredTiles: staggeredTiles,
    );
  }

  // * I want to build a gridView with images in 2 columns and 5 rows.
  // * But with dynamic image height.

  Widget _buildDynamicHeightStaggeredGridView() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2, // ! All staggered tiles will follow this structure.
      itemBuilder: (BuildContext context, int index) {
        return buildImageTiles(
            "https://picsum.photos/id/${index * 2}/200/${100 + 50 * index}");
      },
      itemCount: 10,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: EdgeInsets.all(8.0),
      staggeredTileBuilder: (int index) {
        return StaggeredTile.fit(1); // ! Point is here.
      },
    );
  }

  Widget buildTextTiles(String text) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[300], borderRadius: BorderRadius.circular(10)),
      child: Center(
          child:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 32))),
    );
  }

  Widget buildImageTiles(String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(imgUrl, fit: BoxFit.fill),
    );
  }
}
