import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  ThemeState({@required this.theme, @required this.color})
      : assert(theme != null),
        assert(color != null),
        super([theme, color]);
}
