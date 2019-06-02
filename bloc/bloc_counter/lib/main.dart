import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CounterEvent.dart';
import 'CounterBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // BlocProvider 提供 CounterBloc 給從這邊開始底下的所有 sub tree 使用 (CounterPage)
      home: BlocProvider<CounterBloc>(
        bloc: _counterBloc,
        child: CounterPage(),
      ),
    );
  }

  @override
  void dispose() {
    // 利用 Stateful widget 特性將 bloc dispose 掉
    _counterBloc.dispose();
    super.dispose();
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CounterPage 就可以收到從父節點來的 CounterBloc
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      // BlocBuilder 幫助 presentation 層 dispatch event,
      // 並根據 state 來改變 UI
      // 讓我們在 stateless widget 也可以實現 stateful 的效果
      body: BlocBuilder(
          bloc: _counterBloc,
          builder: (context, count) => Center(
                child: Text(
                  '$count', // 使用 state 值
                  style: TextStyle(fontSize: 24),
                ),
              )),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _counterBloc.dispatch(CounterEvent.increment); // dispatch 實作
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                _counterBloc.dispatch(CounterEvent.decrement); // dispatch 實作
              },
            ),
          ),
        ],
      ),
    );
  }
}
