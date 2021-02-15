import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flowmodoro/services/percentindicator.dart';
import 'package:flowmodoro/services/work.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Styling functionality //

  bool isBreak = false;
  String switchButton = 'Stop working';

  String startButton = 'Start Timer';
  bool isTimerStarted = false;

  //Passing data to the break page
  void goToBreak() {
    Navigator.pushNamed(context, '/break', arguments: {
      'timeElapseHours': stopwatch.elapsed.inHours,
      'timeElapseMinutes': stopwatch.elapsed.inMinutes,
      'timeElapsedSeconds': stopwatch.elapsed.inSeconds
    });
  }

  // Timer Functionality //

  String timerDisplay = "00:00:00";

  // Stopwatch object
  var stopwatch = Stopwatch();

  //Stopping the timer and sending to the break page
  stopTimer() {
    goToBreak();
    isTimerStarted = isTimerStarted ? false : true;
    startButton = isTimerStarted ? 'Pause' : 'Start Timer';
  }

  //Starting the stopwatch
  startStopwatch() {
    Timer(Duration(seconds: 1), keepRunning);
  }

  //Callback function for the stopwatch
  keepRunning() {
    if (stopwatch.isRunning) {
      startStopwatch();
    }
    setState(() {
      timerDisplay = stopwatch.elapsed.inHours.toString().padLeft(2, '0') +
          ":" +
          (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  //Starting the stopwatch
  startTimer() {
    stopwatch.start();
    startStopwatch();
  }

  //Resetting the stopwatch
  resetTimer() {
    stopwatch.reset();
    timerDisplay = "00:00:00";
  }

  //Pausing the stopwatch
  pauseTimer() {
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red[500], Colors.red[300]],
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
                child: Center(
                  child: Container(
                    child: Text(
                      timerDisplay,
                      style: TextStyle(
                          fontSize: 60,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
                                  startButton,
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  setState(() {
                                    isTimerStarted =
                                        isTimerStarted ? false : true;
                                    startButton = isTimerStarted
                                        ? 'Pause'
                                        : 'Start Timer';
                                    if (isTimerStarted) {
                                      startTimer();
                                    } else {
                                      pauseTimer();
                                    }
                                  });
                                },
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
                                  color: Colors.red[300],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    setState(() {
                                      resetTimer();
                                      isTimerStarted = false;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: RaisedButton(
                          onPressed: isTimerStarted
                              ? () {
                                  setState(() {
                                    stopTimer();
                                    pauseTimer();
                                    resetTimer();
                                  });
                                }
                              : null,
                          color: Colors.red[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            switchButton,
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
