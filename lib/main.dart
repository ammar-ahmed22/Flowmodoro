import 'package:flowmodoro/pages/break.dart';
import 'package:flowmodoro/pages/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/break': (context) => Break(),
      
    },
  ));
}
