import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro_demo/fluro/application.dart';
import 'package:fluro_demo/fluro/routes.dart';

void main() {
  setupRouter();
  runApp(MyApp());
}

setupRouter() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluro Demo',
      onGenerateRoute: Application.router.generator,
    );
  }
}
