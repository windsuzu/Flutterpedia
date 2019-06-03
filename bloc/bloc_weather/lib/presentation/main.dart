import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_weather/data/repository/repositories.dart';
import 'package:http/http.dart';
import 'package:bloc_weather/bloc/weather/bloc.dart';
import 'package:bloc_weather/bloc/theme/bloc.dart';
import 'package:bloc_weather/bloc/setting/bloc.dart';
import 'widgets.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: Client(),
    ),
  );

  runApp(MyApp(weatherRepository: weatherRepository));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatefulWidget {
  final WeatherRepository weatherRepository;

  MyApp({@required this.weatherRepository});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc _themeBloc = ThemeBloc();
  SettingBloc _settingBloc = SettingBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc),
        BlocProvider<SettingBloc>(bloc: _settingBloc),
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (context, state) => MaterialApp(
              title: 'Flutter Demo',
              theme: state.theme,
              home: WeatherPage(weatherRepository: widget.weatherRepository),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingBloc.dispose();
    super.dispose();
  }
}

class WeatherPage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  WeatherPage({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Setting(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CitySelection()));
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              BlocProvider.of<ThemeBloc>(context).dispatch(
                WeatherChanged(condition: state.weather.condition),
              );
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();

              final weather = state.weather;
              return BlocBuilder(
                bloc: BlocProvider.of<ThemeBloc>(context),
                builder: (context, themeState) => GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          _weatherBloc.dispatch(
                              RefreshWeather(city: state.weather.location));
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child: Location(location: weather.location),
                              ),
                            ),
                            Center(
                              child: LastUpdated(dateTime: weather.lastUpdated),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              child: Center(
                                child: CombinedWeatherTemperature(
                                  weather: weather,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}
