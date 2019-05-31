import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 測試 Future 值的返回是否成功
  test('Future value returns successfully', () async {
    var value = await Future.value(10);
    expect(value, equals(10));
  });

  // 利用 Completion 測試多個 Futures
  test('test Future using completion', () {
    var futureValue = Future.value('abc');
    var futureResult = futureValue.then((val) => val * 2);
    expect(futureResult, completion(equals('abcabc')));
  });

  // 測試 Exception
  test('Future error', () {
    var errFuture = Future.error('Oops!');
    expect(errFuture, throwsA(equals('Oops!')));

    var errWithTypeFuture = Future.error(StateError('State error'));
    expect(errWithTypeFuture, throwsStateError);
  });

  // 利用 ExpectAsync 來測試 stream 類
  test('Stream test', () {
    var stream = Stream.fromIterable([1, 2, 3, 4, 5]);

    stream.listen(expectAsync1((number) {
      expect(number, inInclusiveRange(0, 5));
    }, count: 5));
  });

  // Stream Matchers ! 驗證每一個進來的 stream item
  test('process status messages', () {
    var status = Stream.fromIterable(['Loading...', 'Start!', 'End.']);

    expect(
        status,
        emitsInOrder([
          startsWith('Load'),
          contains('Start'),
          emitsAnyOf([contains('End'), 'Error.']),
          emitsDone
        ]));
  });

  // 利用 StreamQueue 搭配 expectLater, emitThrough 等技巧 test
  test('Use StreamQueue technique.', () async {
    var queue = StreamQueue(Stream.fromIterable([
      ".",
      "..",
      "...",
      "WebSocket URL:",
      "ws://localhost:1234/",
      "Waiting for connection..."
    ]));

    await expectLater(
        queue, emitsThrough('WebSocket URL:')); // 等待到 web socket 發出 url 前

    var url = Uri.parse(await queue.next); // 利用 next 得到下一句的 url
    expect(url.host, equals('localhost'));
    expect(url.port, equals(1234));

    await expectLater(queue, emits("Waiting for connection..."));
  });
}
