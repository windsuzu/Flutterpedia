import 'package:flutter/material.dart';
import 'login_animation.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  LoginAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addListener(() {
            if (_controller.isCompleted) _pushToHomePage();
          });
    _animation = LoginAnimation(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pushToHomePage() {
    Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        child: HomeScreen(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.blue,
                    Colors.lightBlue[300],
                    Colors.lightBlueAccent
                  ])),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _divider(250),
                          _inputField(Icons.account_circle, "Username"),
                          _divider(8),
                          _inputField(Icons.lock, "Password", obscure: true),
                          _divider(64),
                          _signUpButton(),
                        ],
                      ),
                      _loginButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: Hero(
        tag: "fade",
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: _animation.buttonZoomout.value < 300
                  ? BorderRadius.circular(30)
                  : BorderRadius.zero),
          padding: EdgeInsets.symmetric(
              vertical: _animation.buttonZoomout.value == 70
                  ? 20
                  : _animation.buttonZoomout.value,
              horizontal: _animation.buttonZoomout.value == 70
                  ? _animation.buttonSqueezeAnimation.value
                  : _animation.buttonZoomout.value),
          color: Colors.pink[400],
          child: _animation.buttonSqueezeAnimation.value > 20
              ? Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: .3),
                )
              : _animation.buttonZoomout.value < 300
                  ? SizedBox(
                      width: 23,
                      height: 23,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : null,
          onPressed: () => _controller.forward(),
        ),
      ),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward();
      await _controller.reverse();
    } on TickerCanceled {}
  }

  Widget _divider(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _signUpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.all(12),
            child: Text(
              "Don't have an account? Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
          )),
    );
  }

  Widget _inputField(IconData iconData, String labelText,
      {bool obscure = false}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          obscureText: obscure,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(
                iconData,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(16)),
        ));
  }
}
