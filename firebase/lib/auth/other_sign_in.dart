import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtherSignInSection extends StatefulWidget {
  @override
  _OtherSignInSectionState createState() => _OtherSignInSectionState();
}

class _OtherSignInSectionState extends State<OtherSignInSection> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _tokenSecretController = TextEditingController();

  String _message = '';
  int _selection = 0;
  bool _showAuthSecretTextField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Other Sign In'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text(
                  'Test other providers authentication. (We do not provide an API to obtain the token for below providers. Please use a third party service to obtain token for below providers.)'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio<int>(
                    value: 0,
                    groupValue: _selection,
                    onChanged: _handleRadioButtonSelected,
                  ),
                  Text(
                    'Github',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio<int>(
                    value: 1,
                    groupValue: _selection,
                    onChanged: _handleRadioButtonSelected,
                  ),
                  Text(
                    'Facebook',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Radio<int>(
                    value: 2,
                    groupValue: _selection,
                    onChanged: _handleRadioButtonSelected,
                  ),
                  Text(
                    'Twitter',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(labelText: 'Enter provider\'s token'),
            ),
            Container(
              child: _showAuthSecretTextField
                  ? TextField(
                      controller: _tokenSecretController,
                      decoration: InputDecoration(
                          labelText: 'Enter provider\'s authTokenSecret'),
                    )
                  : null,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  _signInWithOtherProvider();
                },
                child: const Text('Sign in'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleRadioButtonSelected(int value) {
    setState(() {
      _selection = value;
      if (_selection == 2) {
        _showAuthSecretTextField = true;
      } else {
        _showAuthSecretTextField = false;
      }
    });
  }

  void _signInWithOtherProvider() {
    switch (_selection) {
      case 0:
        _signInWithGithub();
        break;
      case 1:
        _signInWithFacebook();
        break;
      case 2:
        _signInWithTwitter();
        break;
      default:
    }
  }

  // Example code of how to sign in with Github.
  void _signInWithGithub() async {
    final AuthCredential credential = GithubAuthProvider.getCredential(
      token: _tokenController.text,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in with Github. ' + user.uid;
      } else {
        _message = 'Failed to sign in with Github. ';
      }
    });
  }

  // Example code of how to sign in with Facebook.
  void _signInWithFacebook() async {
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: _tokenController.text,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in with Facebook. ' + user.uid;
      } else {
        _message = 'Failed to sign in with Facebook. ';
      }
    });
  }

  // Example code of how to sign in with Twitter.
  void _signInWithTwitter() async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: _tokenController.text,
        authTokenSecret: _tokenSecretController.text);
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in with Twitter. ' + user.uid;
      } else {
        _message = 'Failed to sign in with Twitter. ';
      }
    });
  }
}
