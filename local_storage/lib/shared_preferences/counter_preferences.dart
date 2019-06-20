import 'package:shared_preferences/shared_preferences.dart';

class CounterPreferences {
  static String count = 'count';
  static CounterPreferences _instance;
  static SharedPreferences _preferences;

  CounterPreferences._internal();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<CounterPreferences> getInstance() async {
    if (_instance == null) {
      _instance = CounterPreferences._internal();
      await _instance._init();
    }
    return _instance;
  }

  int getCount() {
    return _preferences.getInt(count) ?? 0;
  }

  Future<int> updateCount() async {
    final value = getCount() + 1;
    return _preferences.setInt(count, value).then((success) => value);
  }
}
