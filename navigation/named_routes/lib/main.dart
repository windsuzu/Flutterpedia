import 'package:flutter/material.dart';
import 'page_a.dart';
import 'page_b.dart';
import 'page_c.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Route Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => PageA(),
        '/pageb': (context) => PageB(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/pagec') {
          final String args = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => PageC(
                    content: args,
                  ));
        }
      },
    );
  }
}
