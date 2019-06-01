import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:unit_test/main.dart';

void main() {
  // 在 testWidget 底下可以進行 widget test
  testWidgets('Test appBar title visibility', (WidgetTester tester) async {

    // 首先要把要測試的 widget 創建出來
    await tester.pumpWidget(MyApp());

    // 利用 find 找出 widget
    final title = find.text("Test");

    // 測試是否存在
    expect(title, findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
