import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherScreen extends StatefulWidget {
  @override
  _UrlLauncherScreenState createState() => _UrlLauncherScreenState();
}

class _UrlLauncherScreenState extends State<UrlLauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Url Launcher Example')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Launch url in default browser'),
              onPressed: _launchUrl,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Create email in default email app'),
              onPressed: _launchEmail,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Make a phone call in default phone app'),
              onPressed: _launchPhone,
              shape: StadiumBorder(side: BorderSide()),
            ),
            FlatButton(
              child: Text('Make an message in default sms app'),
              onPressed: _launchSMS,
              shape: StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail() async {
    // mailto:<email address>?subject=<subject>&body=<body>
    const url = 'mailto:windsuzu@gmail.com?subject=News&body=New%20plugin';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhone() async {
    // tel:<phone number>
    const url = 'tel:+1 555 010 999';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchSMS() async {
    // sms:<phone number>
    const url = 'sms:+1 555 010 999';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
