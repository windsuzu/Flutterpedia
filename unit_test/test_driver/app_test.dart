import 'package:test/test.dart'; // not flutter_test !!!!!
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('my app', () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      // First, tap on the button
      await driver.tap(buttonFinder);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(counterTextFinder), "1");
    });

    // 測試捲動 list 的效能
    test('verifies the list contains a specific item', () async {
      // list view
      final listFinder = find.byValueKey('long_list');
      // target item
      final itemFinder = find.byValueKey('item_50_text');

      // 可以記錄在 timeline file 之中
      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(
          listFinder,
          itemFinder,
          // 每次往下捲動 -300
          dyScroll: -300.0,
        );
      });

      expect(
        await driver.getText(itemFinder),
        'Item 50',
      );

      final summary = new TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('scrolling_summary', pretty: true);
      summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
