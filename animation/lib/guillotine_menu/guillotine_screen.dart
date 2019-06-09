import 'package:flutter/material.dart';
import 'guillotine_menu.dart';

class GuillotineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            HomePage(),
            GuillotineMenu(),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff222222),
      child: Column(
        children: <Widget>[
          SizedBox(height: 90.0),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}