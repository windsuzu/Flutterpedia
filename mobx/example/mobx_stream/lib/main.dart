import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:mobx_stream/stream_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Stream Demo',
      home: Provider<StreamStore>.value(
        child: HomePage(),
        value: StreamStore(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StreamStore>(context);

    return Observer(
      builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('MobX Stream Example'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Random number',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${store.randomStream.value}',
                    style: TextStyle(fontSize: 96),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
