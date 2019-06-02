# BLoC Counter

Counter app for bloc example.

## Getting Started

### Bloc Layer

* [Counter Event](lib/CounterEvent.dart)
* [Counter Bloc](lib/CounterBloc.dart)



### Presentation Layer

Implement `BlocProvider` in `MyApp` class, make bloc readable from `CounterPage` class.

And `BlocBuilder` in `CounterPage` help us redraw UI  with Bloc changing state, and dispatch new events. 

* [main](lib/main.dart)



### Testing

* [Counter_Bloc_test](test/counter_bloc_test.dart)