import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class TimerStart extends TimerEvent {
  final int duration;

  TimerStart({@required this.duration}) : super([duration]);

  @override
  String toString() => "Start { duration: $duration }";
}

class TimerPause extends TimerEvent {
  @override
  String toString() => "Pause";
}

class TimerResume extends TimerEvent {
  @override
  String toString() => "Resume";
}

class TimerReset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";
}
