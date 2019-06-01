abstract class Cat {
  String sound() => "Meow";

  bool eatFood(String food, {bool hungry}) => true;

  int walk(List<String> places);

  Future<String> sleep();

  void hunt(String place, String prey) {}
  int lives = 9;
}
