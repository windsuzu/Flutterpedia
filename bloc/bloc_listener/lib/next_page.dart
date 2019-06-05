import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_listener/bloc/navigation/bloc.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go to Home Page'),
          onPressed: () {
            BlocProvider.of<NavigationBloc>(context)
                .dispatch(NavigationEvent.eventHome);
          },
        ),
      ),
    );
  }
}
