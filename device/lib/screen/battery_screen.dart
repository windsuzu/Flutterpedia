import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'dart:async';

class BatteryScreen extends StatefulWidget {
  @override
  _BatteryScreenState createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final Battery _battery = Battery();
  BatteryState _batteryState;
  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((batteryState) {
      setState(() {
        _batteryState = batteryState;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Demo'),
      ),
      body: Center(
        child:
            Text('$_batteryState', style: Theme.of(context).textTheme.display1),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Show battery level',
          child: Icon(Icons.battery_unknown),
          onPressed: _showBatteryLevel),
    );
  }

  void _showBatteryLevel() async {
    final int batteryLevel = await _battery.batteryLevel;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text('Battery: $batteryLevel%'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
