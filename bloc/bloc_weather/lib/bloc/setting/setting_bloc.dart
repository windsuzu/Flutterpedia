import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  @override
  SettingState get initialState =>
      SettingState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is TemperatureUnitsToggled) {
      yield SettingState(
        temperatureUnits:
            currentState.temperatureUnits == TemperatureUnits.celsius
                ? TemperatureUnits.fahrenheit
                : TemperatureUnits.celsius,
      );
    }
  }
}
