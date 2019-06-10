import 'package:flutter/material.dart';
import 'package:animation/hero/hero_home_screen.dart';
import 'package:animation/navigation/navigation_screen.dart';
import 'package:animation/staggered/staggered_screen.dart';
import 'package:animation/guillotine_menu/guillotine_screen.dart';
import 'package:animation/login/login_screen.dart';
import 'package:animation/widget/widget_screen.dart';

void main() => runApp(MyApp());

Map<String, WidgetBuilder> _routes(BuildContext context) {
  return {
    '/': (context) => HomePage(),
    '/widget_screen': (context) => WidgetScreen(),
    '/hero_home_screen': (context) => HeroHomeScreen(),
    '/navigation_screen': (context) => NavigationScreen(),
    '/staggered_screen': (context) => StaggeredScreen(),
    '/guillotine_screen': (context) => GuillotineScreen(),
    '/login_screen': (context) => LoginScreen(),
  };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: _routes(context));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Demo"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildListTile('Widget Animation', context, '/widget_screen'),
            _buildListTile('Hero Animation', context, '/hero_home_screen'),
            _buildListTile(
                'Navigation Animation', context, '/navigation_screen'),
            _buildListTile('Staggered Animation', context, '/staggered_screen'),
            _buildListTile(
                'Guillotine Animation', context, '/guillotine_screen'),
            _buildListTile('Login Animation', context, '/login_screen'),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, BuildContext context, String route) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
