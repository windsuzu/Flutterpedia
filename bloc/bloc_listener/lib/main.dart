import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_listener/home_page.dart';
import 'package:bloc_listener/bloc/data/bloc.dart';
import 'package:bloc_listener/bloc/navigation/bloc.dart';
import 'package:bloc_listener/next_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBloc _dataBloc = DataBloc();
  NavigationBloc _navigationBloc = NavigationBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProviderTree(
          blocProviders: [
            BlocProvider<DataBloc>(
              bloc: _dataBloc,
            ),
            BlocProvider<NavigationBloc>(
              bloc: _navigationBloc,
            ),
          ],
          child: BlocBuilder(
              bloc: _navigationBloc,
              builder: (context, state) {
                if (state is StateNext) {
                  return NextPage();
                }
                if (state is StateHome) {
                  return HomePage();
                }
              })),
    );
  }

  @override
  void dispose() {
    _navigationBloc.dispose();
    _dataBloc.dispose();
    super.dispose();
  }
}
