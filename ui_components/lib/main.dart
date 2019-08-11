import 'package:flutter/material.dart';
import 'package:ui_components/assets_screen.dart';
import 'package:ui_components/auto_size_text_screen.dart';
import 'package:ui_components/backdrop_filter_screen.dart';
import 'package:ui_components/cached_network_image_screen.dart';
import 'package:ui_components/clip_screen.dart';
import 'package:ui_components/in_app_notification_view_screen.dart';
import 'package:ui_components/ink_screen.dart';
import 'package:ui_components/offline_screen.dart';
import 'package:ui_components/wave_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Components',
      routes: {
        "/assets": (_) => AssetsScreen(),
        "/auto_size_text": (_) => AutoSizeTextScreen(),
        "/backdrop_filter": (_) => BackdropFilterScreen(),
        "/cached_network_image": (_) => CachedNetworkImageScreen(),
        "/clip": (_) => ClipScreen(),
        "/in_app_notification_view": (_) => InAppNotificationViewScreen(),
        "/ink": (_) => InkScreen(),
        "/offline": (_) => OfflineScreen(),
        "/wave": (_) => WaveScreen(),
      },
      home: MyHomePage(title: 'UI Components Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${routes.keys.toList()[index]}"),
            onTap: () =>
                Navigator.pushNamed(context, routes.values.toList()[index]),
          );
        },
      ),
    );
  }
}

final routes = {
  "Assets": "/assets",
  "AutoSizeText": "/auto_size_text",
  "BackdropFilter": "/backdrop_filter",
  "Cached Network Image": "/cached_network_image",
  "Clip": "/clip",
  "In-App Notification View": "/in_app_notification_view",
  "Ink": "/ink",
  "Offline": "/offline",
  "Wave": "/wave",
};
