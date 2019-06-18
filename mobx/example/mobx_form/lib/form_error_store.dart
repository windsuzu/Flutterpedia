import 'package:mobx/mobx.dart';

part 'form_error_store.g.dart';

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String username;

  @observable
  String email;

  @observable
  String password;

  @computed
  bool get hasErrors => username != null || email != null || password != null;
}
