import "package:flutter_test/flutter_test.dart";

void main() {
  // 使用 expect 來驗證 String functions
  group('easy tests for string.', () {
    test('split() test', () {
      var string = "apple,banana,cat,dog";
      expect(string.split(","), equals(["apple", "banana", "cat", "dog"]));
    });

    test('trim() test', () {
      var string = "  abc";
      expect(string.trim(), equals("abc"));
    });
  });

  // 使用 expect 來驗證 Int functions
  group('easy test for integer.', () {
    test('integer compare', () {
      expect(1 > 2, false);
    });
    test('base 16 radix', () {
      expect(12.toRadixString(16), 'c');
    });
  });

  // Expect 可以使用各種 function 來搭配，進行複雜驗證
  // contains
  // isNot
  // startsWith, endsWith
  test('split() test.', () {
    expect(
        "abc,def,ghi",
        allOf([
          contains(",def"),
          isNot(startsWith('def')),
          endsWith('hi'),
        ]));
  });
}
