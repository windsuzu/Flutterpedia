import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test finding widgets', (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text(
              "Text",
              key: Key("key"),
            ),
            childWidget,
          ],
        ),
      ),
    ));

    // 利用物件上的文字查詢
    expect(find.text("Text"), findsOneWidget);

    // 利用物件的 key 查詢
    expect(find.byKey(Key("key")), findsOneWidget);

    // 直接利用 instance 查詢
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
