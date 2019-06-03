import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc_weather/data/model/models.dart';

@immutable
abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherError extends WeatherState {}