import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_listener/bloc/navigation/bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => StateHome();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    switch (event) {
      case NavigationEvent.eventHome:
        yield StateHome();
        break;
      case NavigationEvent.eventNext:
        yield StateNext();
        break;
    }
  }
}
