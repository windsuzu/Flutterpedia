import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataState extends Equatable {
  DataState([List props = const []]) : super(props);
}

class Initial extends DataState {}

class Loading extends DataState {}

class Success extends DataState {}
