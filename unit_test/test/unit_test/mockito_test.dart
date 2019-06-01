import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import '../../lib/ForMockito/Post.dart';
import '../../lib/ForMockito/HttpFunction.dart';
import '../../lib/ForMockito/Cat.dart';

class MockClient extends Mock implements Client {}

class MockCat extends Mock implements Cat {}

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

  group('test Cat\'s Functions', () {
    // 可以使用 when + thenReturn 模擬呼叫的結果
    test('mocking cat response', () async {
      var cat = MockCat();
      when(cat.sound()).thenReturn("Meow");
      expect(cat.sound(), "Meow");

      when(cat.lives).thenReturn(9);
      expect(cat.lives, 9);

      when(cat.walk([])).thenThrow(RangeError('NONO'));
      expect(() => cat.walk([]), throwsRangeError);

      // Future & Stream 應使用 thenAnswer 設定
      when(cat.sleep()).thenAnswer((_) => Future.value('wake up'));
      expect(await cat.sleep(), "wake up");
    });

    // verify 可以驗證是否有發生某件事情
    test('cat verifies', () async {
      var cat = MockCat();
      cat.sound();
      verify(cat.sound());

      when(cat.eatFood("fish")).thenReturn(true);
      expect(cat.eatFood('fish'), isTrue);
      verify(cat.eatFood("fish"));

      when(cat.eatFood(argThat(startsWith('dry'))))
          .thenReturn(false); // 吃乾的東西不會飽 (false)
      expect(cat.eatFood('dry fish'), isFalse); // 驗證吃乾魚會不會飽
      verify(cat.eatFood(argThat(startsWith("dry")))); // 驗證剛剛是不是有吃了乾的東西

      // 驗證 cat 去 hunt 過兩次
      cat.hunt('kitchen', null);
      cat.hunt('back yard', argThat(isNull));
      verify(cat.hunt(argThat(isNotNull), any)).called(2);

      // verifyNever
      verifyNever(cat.sound()); // 第二行的 verify 已經驗證過並且註銷掉貓咪發過聲音的次數，所以現在測試等於沒發過聲音

      // verifyInOrders
      cat.sound();
      cat.sleep();
      cat.eatFood(any);
      verifyInOrder([
        cat.sound(),
        cat.sleep(),
        cat.eatFood(any),
      ]);

      // verify 可以用來抓出 arguments
      cat.eatFood("Trash");
      var food = verify(cat.eatFood(captureAny)).captured.single;
      expect(food, isNot("Fish"));

      // 這個指令可以驗證，所有跟 cat 有關可以被 verify 的指令都被驗證完畢了 !
      verifyNoMoreInteractions(cat);
    });
  });
}
