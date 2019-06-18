import 'package:flutter/material.dart';
import 'package:mobx_hacker_news/hacker_news_store.dart';
import 'package:mobx_hacker_news/feed_items_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Hacker News Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final HackerNewsStore store = HackerNewsStore();
  final _tabs = [FeedType.latest, FeedType.top];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_onTabChange);

    store.loadNews(_tabs.first);
    super.initState();
  }

  void _onTabChange() {
    store.loadNews(_tabs[_tabController.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MobX Hacker News Example'),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: 'Newest',
              ),
              Tab(
                text: 'Top',
              )
            ],
          ),
        ),
        body: SafeArea(
            child: TabBarView(controller: _tabController, children: [
          FeedItemsView(store, FeedType.latest),
          FeedItemsView(store, FeedType.top),
        ])));
  }
}
