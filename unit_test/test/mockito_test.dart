import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import '../lib/ForMockito/Post.dart';
import '../lib/ForMockito/HttpFunction.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('test FetchPost success and failure', () {
    test('when FetchPost success', () async {
      final client = MockClient();

      // 利用 when + thenAnswer 來模擬 mock client 成功的反應
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => Response('{"title": "Test"}', 200));

      expect(await fetchPost(client), isInstanceOf<Post>());
    });

    test('when FetchPost fail', () async {
      final client = MockClient();

      // 利用 when + thenAnswer 來模擬 mock client 失敗的反應
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}
