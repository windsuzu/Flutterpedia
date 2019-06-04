import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_weather/bloc/weather/bloc.dart';
import 'package:bloc_weather/data/repository/repositories.dart';
import 'package:bloc_weather/data/model/weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  WeatherBloc weatherBloc;
  MockWeatherRepository weatherRepository;
  Weather weather;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
    weather = Weather(
      condition: WeatherCondition.clear,
      formattedCondition: 'Clear',
      minTemp: 15,
      maxTemp: 20,
      locationId: 0,
      location: 'Taipei',
      lastUpdated: DateTime(2019),
    );
  });

  test('bloc init', () {
    expect(weatherBloc.initialState, WeatherEmpty());
  });

  test('bloc dispose', () {
    expectLater(weatherBloc.state, emitsInOrder([WeatherEmpty(), emitsDone]));
    weatherBloc.dispose();
  });

  test('fetch weather success', () {
    when(weatherRepository.getWeather('taipei'))
        .thenAnswer((_) => Future.value(weather));
    expectLater(
        weatherBloc.state,
        emitsInOrder([
          WeatherEmpty(),
          WeatherLoading(),
          WeatherLoaded(weather: weather)
        ]));
    weatherBloc.dispatch(FetchWeather(city: 'taipei'));
  });

  test('fetch weather error', () {
    when(weatherRepository.getWeather('taipei')).thenThrow('Weather Error');
    expectLater(
        weatherBloc.state,
        emitsInOrder([
          WeatherEmpty(),
          WeatherLoading(),
          WeatherError()
        ]));
    weatherBloc.dispatch(FetchWeather(city: 'taipei'));
  });

  test('refresh weather success', () {
    when(weatherRepository.getWeather('taipei'))
        .thenAnswer((_) => Future.value(weather));
    expectLater(weatherBloc.state, emitsInOrder([WeatherEmpty(), WeatherLoaded(weather: weather)]));
    weatherBloc.dispatch(RefreshWeather(city: 'taipei'));
  });

  test('refresh weather error', () {
    when(weatherRepository.getWeather('taipei')).thenThrow('Weather Error');
    expectLater(weatherBloc.state, emitsInOrder([WeatherEmpty()]));
    weatherBloc.dispatch(RefreshWeather(city: 'taipei'));
  });
}
