import 'package:flutter/material.dart';
import 'package:flowmodoro/pages/home.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          '00:00',
          style: TextStyle(
              fontSize: 60,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
