import 'package:flutter/material.dart';
import 'package:local_storage/streaming_shared_preferences/streaming_counter_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class StreamingCounterPreferencesScreen extends StatefulWidget {
  @override
  _StreamingCounterPreferencesScreenState createState() =>
      _StreamingCounterPreferencesScreenState();
}

class _StreamingCounterPreferencesScreenState
    extends State<StreamingCounterPreferencesScreen> {
  Future<StreamingCounterPreferences> settings;

  @override
  void initState() {
    settings = _setupPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streaming Preferences Example'),
      ),
      body: FutureBuilder<StreamingCounterPreferences>(
        future: settings,
        builder: (context, settings) {
          if (settings.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Center(
            child: PreferenceBuilder<int>(
                preference: settings.data.counter,
                builder: (context, counter) {
                  return Text(
                    'Button tapped $counter time${counter == 1 ? '' : 's'}.\n\n'
                    'This should persist across restarts.',
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add), //Change Icon
      ),
    );
  }

  Future<StreamingCounterPreferences> _setupPreferences() async {
    return StreamingCounterPreferences(
        await StreamingSharedPreferences.instance);
  }

  void _incrementCounter() async {
    await settings.then((data) {
      final int currentCounter = data.counter.getValue();
      data.counter.setValue(currentCounter + 1);
    });
  }
}
