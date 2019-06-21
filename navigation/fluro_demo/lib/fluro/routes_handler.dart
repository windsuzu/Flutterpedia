import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluro_demo/screen/pages.dart';

var rootHandler = Handler(handlerFunc: (context, params) => PageA());

var pageBHandler = Handler(handlerFunc: (context, params) {
  String message = params["message"][0];
  return PageB(
    message: message,
  );
});

var pageCHandler = Handler(handlerFunc: (context, params) => PageC());

var pageDHandler = Handler(handlerFunc: (context, params) => PageD());
