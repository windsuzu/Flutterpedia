import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_multi_counter/multi_counter_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Multi Counter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MultiCounterStore store = MultiCounterStore();

    return Scaffold(
      appBar: AppBar(
        title: Text('MobX Multi Counter Example'),
      ),
      body: Observer(
          builder: (_) => Column(children: <Widget>[
                RaisedButton(
                  onPressed: store.addCounter,
                  child: const Text('Add Counter'),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: store.counters.length,
                    itemBuilder: (_, index) => ListTile(
                        trailing: const Icon(Icons.navigate_next),
                        title: Text('Count: ${store.counters[index].value}'),
                        leading: IconButton(
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed: () => store.removeCounter(index)),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Scaffold(
                                    appBar: AppBar(
                                      title: const Text('Multi Counter'),
                                    ),
                                    body: CounterViewPage(
                                        store: store, index: index)),
                              ),
                            )))
              ])),
    );
  }
}

class CounterViewPage extends StatelessWidget {
  const CounterViewPage({@required this.store, @required this.index});

  final int index;
  final MultiCounterStore store;

  @override
  Widget build(BuildContext context) {
    final counter = store.counters[index];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  child: const Icon(Icons.remove),
                  onPressed: counter.decrement,
                ),
                Expanded(
                  child: Center(
                    child: Observer(
                        builder: (_) => Text(
                              '${counter.value}',
                              style: const TextStyle(fontSize: 20),
                            )),
                  ),
                ),
                RaisedButton(
                  child: const Icon(Icons.add),
                  onPressed: counter.increment,
                ),
              ],
            ),
            FlatButton(
              child: const Text('Reset'),
              textColor: Colors.red,
              onPressed: counter.reset,
            )
          ],
        ),
      ),
    );
  }
}
