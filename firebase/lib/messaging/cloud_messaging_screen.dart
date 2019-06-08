import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudMessagingScreen extends StatefulWidget {
  @override
  _CloudMessagingScreenState createState() => _CloudMessagingScreenState();
}

class _CloudMessagingScreenState extends State<CloudMessagingScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String token;

  @override
  void initState() {
    configureFirebaseMessaging();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTokenInfo(token),
            TopicSwitch(
              hint: "Subscribe to Apple",
              topic: 'apple',
              firebaseMessaging: _firebaseMessaging,
            ),
            TopicSwitch(
              hint: "Subscribe to Banana",
              topic: 'banana',
              firebaseMessaging: _firebaseMessaging,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenInfo(String token) => Text('Your token: $token');

  void _showNotificationSnackBar(Map<String, dynamic> message) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(message['notification']['body'])));
  }

  // If you want to click the notification and push to a specific screen:
  // https://stackoverflow.com/questions/48403786/how-to-open-particular-screen-on-clicking-on-push-notification-for-flutter

  void configureFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotificationSnackBar(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        this.token = token;
      });
    });
  }
}

class TopicSwitch extends StatefulWidget {
  final FirebaseMessaging firebaseMessaging;
  final String hint;
  final String topic;

  TopicSwitch({@required this.topic, this.hint, this.firebaseMessaging});

  @override
  _TopicSwitchState createState() => _TopicSwitchState();
}

class _TopicSwitchState extends State<TopicSwitch> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _switchState;

  String get _topic => widget.topic;

  String get _hint => widget.hint;

  FirebaseMessaging get _firebaseMessaging => widget.firebaseMessaging;

  @override
  void initState() {
    super.initState();
    fetchSwitchState();
  }

  void fetchSwitchState() async {
    final SharedPreferences prefs = await _prefs;
    _switchState = (prefs.getBool(_topic) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('$_hint'),
        Switch(
          value: (_switchState ?? false),
          onChanged: (newState) => _onSwitchChange(newState),
        )
      ],
    );
  }

  _onSwitchChange(bool newState) async {
    final SharedPreferences prefs = await _prefs;
    if (newState) {
      _subscribeToTopic();
    } else {
      _unsubscribeToTopic();
    }
    prefs.setBool(_topic, newState);
    setState(() {
      _switchState = newState;
    });
  }

  _subscribeToTopic() {
    _firebaseMessaging.subscribeToTopic(_topic);
  }

  _unsubscribeToTopic() {
    _firebaseMessaging.unsubscribeFromTopic(_topic);
  }
}
