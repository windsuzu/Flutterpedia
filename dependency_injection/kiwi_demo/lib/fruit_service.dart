class FruitService {
  Fruit fruit;

  String description() => fruit.description();
}

abstract class Fruit {
  String description();
}

class Kiwi extends Fruit {
  @override
  String description() => 'A kiwi';
}

class Apple extends Fruit {
  @override
  String description() => 'An apple';
}

class Banana extends Fruit {
  @override
  String description() => 'A banana';
}

class Grape extends Fruit {
  @override
  String description() => 'A grape';
}

class GrapeAppleJuice {
  Grape grape;
  Apple apple;

  GrapeAppleJuice(this.grape, this.apple);

  String description() =>
      'This is grape apple juice with ${apple.description()} and ${grape.description()}.';
}
