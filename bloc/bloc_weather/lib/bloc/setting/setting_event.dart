import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingEvent extends Equatable {
  SettingEvent([List props = const []]) : super(props);
}

class TemperatureUnitsToggled extends SettingEvent {}