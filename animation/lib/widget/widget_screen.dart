import 'package:flutter/material.dart';
import 'widgets.dart';

// I use AnimatedList here, check out: https://flutterchina.club/catalog/samples/animated-list/
class WidgetScreen extends StatefulWidget {
  @override
  _WidgetScreenState createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<List> items = [
    ['AnimatedOpacity', AnimatedOpacityScreen()],
    ['AnimatedDefaultTextStyle', AnimatedDefaultTextStyleScreen()],
    ['AnimatedCrossFade', AnimatedCrossFadeScreen()],
    ['AnimatedContainer', AnimatedContainerScreen()],
    ['AnimatedAlign', AnimatedAlignScreen()],
    ['AnimatedPositioned', AnimatedPositionedScreen()],
    ['AnimatedPadding', AnimatedPaddingScreen()],
    ['AnimatedSwitcher', AnimatedSwitcherScreen()],
    ['DecoratedBoxTransition', DecoratedBoxTransitionScreen()],
    ['PositionedTransition', PositionedTransitionScreen()],
  ];
  List<List> _tiles = [];

  @override
  void initState() {
    super.initState();
    fillListTiles();
  }

  void fillListTiles() async {
    for (List item in items) {
      await Future.delayed(Duration(milliseconds: 100), () {
        _insert(_tiles.length, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Animation'),
      ),
      body: AnimatedList(
          key: _listKey,
          initialItemCount: _tiles.length,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
              position: animation
                  .drive(Tween(begin: Offset(-1, 0), end: Offset.zero)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    onTap: () {
                      _pushToWidgetPage(route: _tiles[index][1]);
                    },
                    title: Text(_tiles[index][0]),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _insert(int index, List item) {
    _tiles.insert(index, item);
    _listKey.currentState.insertItem(index);
  }

  void _pushToWidgetPage({Widget route}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
