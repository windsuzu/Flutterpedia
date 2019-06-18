// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors)).value;

  final _$usernameAtom = Atom(name: '_FormErrorStore.username');

  @override
  String get username {
    _$usernameAtom.reportObserved();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.context.checkIfStateModificationsAreAllowed(_$usernameAtom);
    super.username = value;
    _$usernameAtom.reportChanged();
  }

  final _$emailAtom = Atom(name: '_FormErrorStore.email');

  @override
  String get email {
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.checkIfStateModificationsAreAllowed(_$emailAtom);
    super.email = value;
    _$emailAtom.reportChanged();
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.checkIfStateModificationsAreAllowed(_$passwordAtom);
    super.password = value;
    _$passwordAtom.reportChanged();
  }
}
