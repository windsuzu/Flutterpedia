import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationState extends Equatable {
  NavigationState([List props = const []]) : super(props);
}

class InitialNavigationState extends NavigationState {}

class StateHome extends NavigationState {}

class StateNext extends NavigationState {}
