import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_login/data/user_repository.dart';
import 'package:bloc_login/bloc/authentication/authentication.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
  });

  test('bloc init', () {
    expect(authenticationBloc.initialState, AuthenticationUninitialized());
  });

  test('bloc dispose', () {
    expectLater(
      authenticationBloc.state,
      emitsInOrder([AuthenticationUninitialized(), emitsDone]),
    );
    authenticationBloc.dispose();
  });

  test('app started', () {
    when(userRepository.hasToken()).thenAnswer((_) => Future.value(false));
    expectLater(
      authenticationBloc.state,
      emitsInOrder(
          [AuthenticationUninitialized(), AuthenticationUnauthenticated()]),
    );
    authenticationBloc.dispatch(AppStarted());
  });

  test('app login', () {
    expectLater(
        authenticationBloc.state,
        emitsInOrder([
          AuthenticationUninitialized(),
          AuthenticationLoading(),
          AuthenticationAuthenticated()
        ]));
    authenticationBloc.dispatch(LoggedIn(token: 'token'));
  });

  test('app logout', () {
    expectLater(
        authenticationBloc.state,
        emitsInOrder([
          AuthenticationUninitialized(),
          AuthenticationLoading(),
          AuthenticationUnauthenticated()
        ]));
    authenticationBloc.dispatch(LoggedOut());
  });
}
