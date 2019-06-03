import 'package:flutter/material.dart';
import 'package:bloc_weather/data/model/models.dart';
import 'weather_conditions.dart';
import 'temperature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_weather/bloc/setting/bloc.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final Weather weather;

  CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: WeatherConditions(condition: weather.condition),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: BlocBuilder(
                bloc: BlocProvider.of<SettingBloc>(context),
                builder: (context, state) => Temperature(
                      temperature: weather.temp,
                      high: weather.maxTemp,
                      low: weather.minTemp,
                      units: state.temperatureUnits,
                    ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
