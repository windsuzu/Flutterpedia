import 'package:flutter/material.dart';
import 'package:local_storage/shared_preferences/counter_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Future<CounterPreferences> _preferences = CounterPreferences.getInstance();
  Future<int> _counter;

  @override
  void initState() {
    _counter = _preferences.then((pref) => pref.getCount());
    super.initState();
  }

  void _incrementCounter() async {
    _counter = _preferences.then((pref) => pref.updateCount());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences Example'),
      ),
      body: Center(
        child: FutureBuilder<int>(
            future: _counter,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return Text(
                  'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                  'This should persist across restarts.',
                );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add), //Change Icon
      ),
    );
  }
}
