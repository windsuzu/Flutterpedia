import 'package:flutter/widgets.dart';

// This file will contain keys which we will use to uniquely identify important widgets.
// We can later write tests that find widgets based on keys.

class FlutterTodosKeys {
  static final extraActionsPopupMenuButton =
  const Key('__extraActionsPopupMenuButton__');
  static final extraActionsEmptyContainer =
  const Key('__extraActionsEmptyContainer__');
  static final filteredTodosEmptyContainer =
  const Key('__filteredTodosEmptyContainer__');
  static final statsLoadingIndicator = const Key('__statsLoadingIndicator__');
  static final emptyStatsContainer = const Key('__emptyStatsContainer__');
  static final emptyDetailsContainer = const Key('__emptyDetailsContainer__');
  static final detailsScreenCheckBox = const Key('__detailsScreenCheckBox__');
}