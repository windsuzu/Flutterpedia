import 'package:flutter/material.dart';

class InkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ink Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildRippleEffectContainer(),
                SizedBox(height: 12),
                _buildRippleEffectImage(),
              ]),
        ),
      ),
    );
  }

  Widget _buildRippleEffectContainer() {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {/* ... */},
            splashColor: Colors.yellow,
            child: Container(
              width: 200,
              height: 100,
              child: Center(
                child: Text(
                  'Hello World',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildRippleEffectImage() {
    return Material(
      type: MaterialType.transparency,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage("assets/dog_image.jpeg"),
                  fit: BoxFit.cover)),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {/* ... */},
            splashColor: Colors.yellow.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
