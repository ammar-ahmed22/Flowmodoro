import 'package:flutter/material.dart';
import 'package:flowmodoro/pages/home.dart';
import 'package:flowmodoro/pages/break.dart';
import 'package:flowmodoro/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/loading': (context) => Loading(),
      '/break': (context) => Break(),
    },
  ));
}
