import 'package:flutter/material.dart';
import 'package:firebase/auth/auths.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildUserInformationSection(),
            Container(
              child: FlatButton(
                child: Text('Email Password Sign In'),
                onPressed: () => _pushScreen(context, EmailPasswordForm()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: FlatButton(
                child: Text('Anonymously Sign In'),
                onPressed: () =>
                    _pushScreen(context, AnonymouslySignInSection()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: FlatButton(
                child: Text('Google Sign In'),
                onPressed: () => _pushScreen(context, GoogleSignInSection()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: FlatButton(
                child: Text('Phone Sign In'),
                onPressed: () => _pushScreen(context, PhoneSignInSection()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: FlatButton(
                child: Text('Other Sign In'),
                onPressed: () => _pushScreen(context, OtherSignInSection()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              child: FlatButton(
                child: Text(
                  'Registration',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () => _pushScreen(context, RegisterScreen()),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInformationSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Text(
              '${_user == null ? "No one has signed in." : "${_user.email} signed in successfully"}'),
          FlatButton(onPressed: () => _signOut(), child: Text('Sign Out'))
        ],
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
    _user = null;
    setState(() {});
  }

  void _pushScreen(BuildContext context, Widget page) async {
    final String result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
    if (result != null) _user = await _auth.currentUser();
    setState(() {});
  }
}
