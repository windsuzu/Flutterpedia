import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/bloc/bloc.dart';
import '../lib/data/post_repository.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  PostBloc postBloc;
  MockPostRepository postRepository;

  setUp(() {
    postRepository = MockPostRepository();
    postBloc = PostBloc(postRepository: postRepository);
  });

  test('bloc init', () {
    expect(postBloc.initialState, PostUninitialized());
  });

  test('fetch success', () {
    when(postRepository.getPosts(any, any)).thenAnswer((_) => Future.value([]));

    expectLater(
        postBloc.state,
        emitsInOrder([
          PostUninitialized(),
          PostLoaded(posts: [], hasReachedMax: false)
        ]));

    postBloc.dispatch(Fetch());
  });

  test('fetch error', () {
    when(postRepository.getPosts(any, any)).thenThrow('Post Error');

    expectLater(
        postBloc.state, emitsInOrder([PostUninitialized(), PostError()]));

    postBloc.dispatch(Fetch());
  });

  test('bloc dispose', () {
    expectLater(postBloc.state, emitsInOrder([PostUninitialized(), emitsDone]));
    postBloc.dispose();
  });
}
