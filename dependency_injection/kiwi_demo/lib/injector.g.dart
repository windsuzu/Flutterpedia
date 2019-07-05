// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory<Fruit, Kiwi>((c) => Kiwi());
    container.registerFactory((c) => Apple(), name: 'apple');
    container.registerFactory((c) => Grape(), name: 'grape');
    container.registerFactory(
        (c) => GrapeAppleJuice(c<Grape>('grape'), c<Apple>('apple')));
    container.registerSingleton((c) => Banana());
  }
}
