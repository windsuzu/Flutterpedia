import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../data/ticker.dart';
import 'package:meta/meta.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required this.ticker});

  @override
  TimerState get initialState => Ready(_duration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStart) {
      yield* _mapStartToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    } else if (event is TimerPause) {
      yield* _mapPauseToState(event);
    } else if (event is TimerResume) {
      yield* _mapResumeToState(event);
    } else if (event is TimerReset) {
      yield* _mapResetToState(event);
    }
  }

  Stream<TimerState> _mapStartToState(TimerStart timerStart) async* {
    yield Running(timerStart.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription =
        ticker.tick(ticks: timerStart.duration).listen((duration) {
      dispatch(Tick(duration: duration));
    });
  }

  Stream<TimerState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }

  Stream<TimerState> _mapPauseToState(TimerPause pause) async* {
    if (currentState is Running) {
      _tickerSubscription?.pause();
      yield Pause(currentState.duration);
    }
  }

  Stream<TimerState> _mapResumeToState(TimerResume resume) async* {
    if (currentState is Pause) {
      _tickerSubscription?.resume();
      yield Running(currentState.duration);
    }
  }

  Stream<TimerState> _mapResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(_duration);
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}
