import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flare Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flare Demo'),
      ),
      body: Center(child: _buildMyHeart()),
    );
  }

  Widget _buildMyHeart() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLike = !isLike;
        });
      },
      child: FlareActor(
        'assets/MyHeart.flr',
        animation: isLike ? 'dislike' : 'like',
        alignment: Alignment.center,
      ),
    );
  }
}
