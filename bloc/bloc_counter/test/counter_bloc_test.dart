import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_counter/CounterBloc.dart';
import 'package:bloc_counter/CounterEvent.dart';

void main() {
  CounterBloc _counterBloc;
  setUp(() {
    _counterBloc = CounterBloc();
  });

  tearDown(() {
    _counterBloc.dispose();
  });

  test('init counter bloc', () {
    expect(_counterBloc.initialState, 0);
  });

  test('count increment from 0 to 1', () {
    expectLater(_counterBloc.state, emitsInOrder([0, 1]));
    _counterBloc.dispatch(CounterEvent.increment);
  });

  test('count decrement from 0 to -1', () {
    expectLater(_counterBloc.state, emitsInOrder([0, -1]));
    _counterBloc.dispatch(CounterEvent.decrement);
  });
}
