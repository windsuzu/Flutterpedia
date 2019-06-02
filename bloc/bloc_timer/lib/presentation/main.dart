import 'package:flutter/material.dart';
import '../data/ticker.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'actions.dart';
import 'background.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TimerBloc _timerBloc = TimerBloc(ticker: Ticker());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        bloc: _timerBloc,
        child: TimerPage(),
      ),
    );
  }

  @override
  void dispose() {
    _timerBloc.dispose();
    super.dispose();
  }
}

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: BlocBuilder(
                      bloc: _timerBloc,
                      builder: (context, state) {
                        final String minutesStr = ((state.duration / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        final String secondsStr = (state.duration % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');

                        return Text(
                          "$minutesStr:$secondsStr",
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        );
                      }),
                ),
              ),
              BlocBuilder(
                // Condition 為 true 時，才會 Rebuild
                // 也就是當 State 有轉換時，才會 Rebuild Actions 這個 Widget
                // 這個可以避免在不斷 tick 時，不會去 Rebuild Actions，因為 (Running => Running)
                condition: (previousState, currentState) =>
                    currentState.runtimeType != previousState.runtimeType,
                bloc: _timerBloc,
                builder: (context, state) => Actions(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
