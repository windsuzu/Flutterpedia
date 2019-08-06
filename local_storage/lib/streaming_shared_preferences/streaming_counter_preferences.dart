import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// * Use a wrapper class when having multiple preferences
class StreamingCounterPreferences {
  static final counterKey = 'counter';
  StreamingCounterPreferences(StreamingSharedPreferences preferences)
      : counter = preferences.getInt(counterKey, defaultValue: 0);

  final Preference<int> counter;
}
