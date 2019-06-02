import 'package:flutter_test/flutter_test.dart';
import '../lib/bloc/bloc.dart';
import '../lib/data/ticker.dart';

void main() {
  TimerBloc _timerBloc;
  setUp(() {
    _timerBloc = TimerBloc(ticker: Ticker());
  });

  tearDown(() {
    _timerBloc.dispose();
  });

  test('init timer bloc', () {
    expect(_timerBloc.initialState, Ready(60));
  });

  test('start correct', () {
    expectLater(
        _timerBloc.state, emitsInOrder([Ready(60), Running(60), Running(59)]));
    _timerBloc.dispatch(TimerStart(duration: 60));
  });

  test('finish correct', () {
    expectLater(
        _timerBloc.state, emitsInOrder([Ready(60), Running(1), Finished()]));
    _timerBloc.dispatch(TimerStart(duration: 1));
  });

  test('pause correct', () {
    expectLater(
        _timerBloc.state, emitsInOrder([Ready(60), Running(60), Pause(60)]));
    _timerBloc.dispatch(TimerStart(duration: 60));
    _timerBloc.dispatch(TimerPause());
  });

  test('resume correct', () {
    expectLater(_timerBloc.state,
        emitsInOrder([Ready(60), Running(60), Pause(60), Running(60)]));
    _timerBloc.dispatch(TimerStart(duration: 60));
    _timerBloc.dispatch(TimerPause());
    _timerBloc.dispatch(TimerResume());
  });

  test('reset correct', () {
    expectLater(_timerBloc.state, emitsInOrder([Ready(60)]));
    _timerBloc.dispatch(TimerReset());
  });
}
