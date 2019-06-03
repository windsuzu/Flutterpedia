import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../data/post_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository;

  PostBloc({this.postRepository});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> transform(Stream<PostEvent> events,
      Stream<PostState> Function(PostEvent event) next) {
    return super.transform(
        (events as Observable<PostEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await postRepository.getPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final posts = await postRepository.getPosts(
              (currentState as PostLoaded).posts.length, 20);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
