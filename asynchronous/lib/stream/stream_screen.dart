import 'dart:async';
import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  final List<String> methods = [
    "Periodic",
    "Take",
    "TakeWhile",
    "Skip",
    "SkipWhile",
    "Where",
    "ToList",
    "ForEach",
    "Length",
  ];

  List<String> dataList = List.generate(9, (_) => "");

  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stream Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.stop),
          backgroundColor: Colors.red,
          onPressed: _stopSubscription,
          tooltip: "Stop Any Stream",
        ),
        body: ListView.builder(
          itemCount: methods.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Text(
                dataList[index],
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              title: Text(methods[index]),
              onTap: () => _performTasks(index),
            );
          },
        ),
      ),
    );
  }

  void _performTasks(int index) {
    if (_subscription != null) {
      _stopSubscription();
    }

    switch (index) {
      case 0:
        _performStreamPeriodic();
        break;
      case 1:
        _performStreamTake();
        break;
      case 2:
        _performStreamTakeWhile();
        break;
      case 3:
        _performStreamSkip();
        break;
      case 4:
        _performStreamSkipWhile();
        break;
      case 5:
        _performStreamWhere();
        break;
      case 6:
        _performStreamToList();
        break;
      case 7:
        _performStreamForEach();
        break;
      case 8:
        _performStreamLength();
        break;

      default:
        break;
    }
  }

  // * It will print 1, 2, 3 ... endlessly.
  void _performStreamPeriodic() {
    _subscription =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => (int + 1))
            .listen((data) {
      setState(() {
        dataList[0] = "$data";
      });
    });
  }

  // * It will print 2, 4, 6, 8, 10 and stop.
  void _performStreamTake() {
    _subscription = Stream<int>.periodic(
            Duration(milliseconds: 200), (int) => (int + 1) * 2)
        .take(5)
        .listen((data) {
      setState(() {
        dataList[1] = "$data";
      });
    });
  }

  // * It will only print even number from 1, 2, 3, ... until 10.
  void _performStreamTakeWhile() {
    _subscription =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .takeWhile((data) => data <= 10)
            .listen((data) {
      setState(() {
        dataList[2] = "$data";
      });
    });
  }

  // * It will skip the first 2 numbers and take 5 numbers
  // * So it will print 3, 4, 5, 6, 7
  void _performStreamSkip() {
    _subscription =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .skip(2)
            .take(5)
            .listen((data) {
      setState(() {
        dataList[3] = "$data";
      });
    });
  }

  // * It will skip until the number is bigger than 2
  // * So it will print 3, 4, 5, ... endlessly.
  void _performStreamSkipWhile() {
    _subscription =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .skipWhile((data) => data < 2)
            .listen((data) {
      setState(() {
        dataList[4] = "$data";
      });
    });
  }

  // * It will only print the prime numbers endlessly.
  void _performStreamWhere() {
    _subscription =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .where((data) => isPrime(data))
            .listen((data) {
      setState(() {
        dataList[5] = "$data";
      });
    });
  }

  // * await some times and turn stream into general List.
  void _performStreamToList() async {
    var stream =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .take(5);
    // * It should wait 200 * 5 milliseconds
    List<int> data = await stream.toList();
    setState(() {
      dataList[6] = "${data.toString()}";
    });
  }

  // * Use [for each] to print the stream
  void _performStreamForEach() {
    var stream =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .take(5);

    stream.forEach((int data) {
      setState(() {
        dataList[7] = "$data";
      });
    });
  }

  // * We can get the stream length when your length is fixed.
  void _performStreamLength() async {
    var stream =
        Stream<int>.periodic(Duration(milliseconds: 200), (int) => int + 1)
            .take(10);

    // * It should wait 200 * 10 milliseconds
    var length = await stream.length;
    setState(() {
      dataList[8] = "$length";
    });
  }

  @override
  void dispose() {
    _stopSubscription();
    super.dispose();
  }

  void _stopSubscription() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  bool isPrime(int number) {
    for (int i = 2; i < number; i++) {
      if (number % i == 0 && i != number) return false;
    }
    return true;
  }
}
