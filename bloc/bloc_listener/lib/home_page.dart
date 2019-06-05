import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_listener/bloc/data/bloc.dart';
import 'package:bloc_listener/bloc/navigation/bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<DataBloc>(context).dispatch(FetchData());
              },
              child: Icon(Icons.play_arrow),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<NavigationBloc>(context)
                    .dispatch(NavigationEvent.eventNext);
              },
              child: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
      body: BlocListener(
          bloc: BlocProvider.of<DataBloc>(context),
          listener: (context, state) {
            if (state is Success) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green, content: Text('Success')));
            }
          },
          child: BlocBuilder(
              bloc: BlocProvider.of<DataBloc>(context),
              builder: (context, state) {
                if (state is Initial) {
                  return Center(child: Text('Press the Button'));
                }
                if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is Success) {
                  return Center(child: Text('Success'));
                }
              })),
    );
  }
}
