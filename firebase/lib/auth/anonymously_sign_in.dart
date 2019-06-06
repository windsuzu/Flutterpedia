import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class AnonymouslySignInSection extends StatefulWidget {
  @override
  _AnonymouslySignInSectionState createState() =>
      _AnonymouslySignInSectionState();
}

class _AnonymouslySignInSectionState extends State<AnonymouslySignInSection> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _success;
  String _userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Anonymously Sign In')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text('Test sign in anonymously'),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                _signInAnonymously();
              },
              child: const Text('Sign in anonymously'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                      ? 'Successfully signed in, uid: ' + _userID
                      : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  void _signInAnonymously() async {
      final FirebaseUser user = await _auth.signInAnonymously();

      assert(user != null);
      assert(user.isAnonymous);
      assert(!user.isEmailVerified);
      assert(await user.getIdToken() != null);
      if (Platform.isIOS) {
        // Anonymous auth doesn't show up as a provider on iOS
        assert(user.providerData.isEmpty);
      } else if (Platform.isAndroid) {
        // Anonymous auth does show up as a provider on Android
        assert(user.providerData.length == 1);
        assert(user.providerData[0].providerId == 'firebase');
        assert(user.providerData[0].uid != null);
        assert(user.providerData[0].displayName == null);
        assert(user.providerData[0].photoUrl == null);
        assert(user.providerData[0].email == null);
      }

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      setState(() {
        if (user != null) {
          _success = true;
          _userID = user.uid;
        } else {
          _success = false;
        }

      });
  }
}
