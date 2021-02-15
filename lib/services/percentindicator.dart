import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicator extends StatefulWidget {
  @override
  _PercentIndicatorState createState() => _PercentIndicatorState();
}

class _PercentIndicatorState extends State<PercentIndicator> {
  String breakTime = '00:00';
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
    percent: 0.2,
    animation: true,
    animateFromLastPercent: true,
    radius: 250,
    lineWidth: 20,
    progressColor: Colors.cyan[600],
    center: Text(
      '$breakTime',
      style: TextStyle(
        fontSize: 40,
        color: Colors.white
      ),
    ),
  );
  }
}