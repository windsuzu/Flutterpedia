import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'routes_handler.dart';

class Routes {
  static String root = '/';
  static String pageB = '/page_b';
  static String pageC = '/page_c';
  static String pageD = '/page_d';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);
    router.define(pageB,
        handler: pageBHandler, transitionType: TransitionType.inFromLeft);
    router.define(pageC,
        handler: pageCHandler, transitionType: TransitionType.inFromBottom);
    router.define(pageD,
        handler: pageDHandler, transitionType: TransitionType.native);
  }
}
