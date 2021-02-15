import 'package:flutter/material.dart';
import 'package:flowmodoro/services/percentindicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  Map data = {};
  bool isTimerStarted = false;

  void goBackToWork() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue[500], Colors.blue[300]],
                begin: FractionalOffset(0.5, 1))),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Flowmodoro',
                  style: TextStyle(
                      fontSize: 40, letterSpacing: 2, fontFamily: 'Cairo'),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: CircularPercentIndicator(
                  percent: data['percentIndicator'],
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 250,
                  lineWidth: 20,
                  progressColor: Colors.cyan[600],
                  center: Text(
                    '00:00',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: RaisedButton.icon(
                                icon: Icon(
                                  isTimerStarted
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  isTimerStarted ? 'Pause' : 'Start Timer',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {},
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: RaisedButton.icon(
                                icon: Icon(
                                  Icons.repeat,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Reset',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: RaisedButton(
                          onPressed: () {
                            goBackToWork();
                          },
                          color: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'Start Working',
                            style: TextStyle(
                                fontSize: 40,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
