import 'package:flutter_test/flutter_test.dart';

void main() {
  Uri uri;

  setUp(() {
    uri = Uri.parse("http://www.google.com.tw");
  });
  tearDown(() {
    uri = null;
  });

  test('uri connection', () {
    expect(uri.host, 'www.google.com.tw');
  });
}
