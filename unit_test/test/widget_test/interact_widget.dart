import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/ForWidget/TodoList.dart';

/// 在 TodoList 中
/// TextField 可以輸入文字
/// 按下 Floating button 會將文字加入到 todoList 中
/// 可以利用 swipe 將 todoItem 移除

void main() {
  testWidgets('Test TodoList', (WidgetTester tester) async {
    await tester.pumpWidget(TodoList());

    // 輸入 work 到 textField
    await tester.enterText(find.byType(TextField), 'work');

    // 按下 + button
    await tester.tap(find.byIcon(Icons.add));

    // 更新介面 !!!
    await tester.pump();

    // 這時應該要有一個 todoItem 含有 work 字樣
    expect(find.text('work'), findsOneWidget);

    // 現在將 item 刪掉 (往右刷掉)
    await tester.drag(find.byType(Dismissible), Offset(500, 0));

    // 更新介面 !!! (且因為有 animation 所以要使用 pump settle)
    await tester.pumpAndSettle();

    // 這時應該找不到 todoItem 了
    expect(find.text('work'), findsNothing);
  });
}
