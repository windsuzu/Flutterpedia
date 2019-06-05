import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataEvent extends Equatable {
  DataEvent([List props = const []]) : super(props);
}

class FetchData extends DataEvent {}
