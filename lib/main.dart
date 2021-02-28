import 'package:flowmodoro/pages/break.dart';
import 'package:flowmodoro/pages/home.dart';
import 'package:flowmodoro/pages/info.dart';
import 'package:flowmodoro/pages/menu.dart';
import 'package:flowmodoro/pages/settings.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/break': (context) => Break(),
      '/menu': (context) => Menu(),
      '/settings' : (context) => Settings(),
      '/info': (context) => Info()
      
    },
  ));
}
