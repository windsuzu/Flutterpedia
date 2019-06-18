import 'dart:math';
import 'package:mobx/mobx.dart';

part 'stream_store.g.dart';

class StreamStore = _StreamStore with _$StreamStore;

abstract class _StreamStore with Store {
  final _random = Random();
  Stream<int> _stream;
  ObservableStream<int> randomStream;

  _StreamStore() {
    _stream = Stream<int>.periodic(Duration(seconds: 1))
        .map((x) => _random.nextInt(100));
    randomStream = ObservableStream(_stream, initialValue: 0);
  }
}
