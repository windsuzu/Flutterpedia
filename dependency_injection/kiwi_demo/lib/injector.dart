import 'package:kiwi/kiwi.dart';
import 'package:kiwi_demo/fruit_service.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(Fruit, from: Kiwi)
  @Register.factory(Apple, name: 'apple')
  @Register.factory(Grape, name: 'grape')
  @Register.factory(GrapeAppleJuice, resolvers: {Apple: 'apple', Grape: 'grape'})
  @Register.singleton(Banana)
  void configure();
}

void setupInjector() {
  new _$Injector().configure();
}