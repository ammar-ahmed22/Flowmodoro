import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  Map data = {};

  String switchButton = 'Stop working';

  String startButton = 'Start Break';
  bool isTimerStarted = false;

  stopTimer() {
    goBackToWork();
    stopwatch.stop();
    dispose();
  }

  void goBackToWork() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  double percent = 1;
  int breakDivider = 5;
  int workTimeInSecs;
  Timer _timer;
  String timerDisplay = '00:00:00';
  int breakTimeSecs;

  var stopwatch = Stopwatch();

  startStopwatch() {
    setState(() {
      _timer = Timer(Duration(seconds: 1), keepRunning);
    });
  }

  keepRunning() {
    if (stopwatch.isRunning) {
      startStopwatch();
    }

    if ((breakTimeSecs - stopwatch.elapsed.inSeconds) >= 0) {
      setState(() {
        timerDisplay = ((breakTimeSecs / 3600).floor() -
                    stopwatch.elapsed.inHours)
                .toString()
                .padLeft(2, '0') +
            ":" +
            (((breakTimeSecs / 60).floor() - stopwatch.elapsed.inMinutes) % 60)
                .toString()
                .padLeft(2, '0') +
            ':' +
            ((breakTimeSecs - stopwatch.elapsed.inSeconds) % 60)
                .toString()
                .padLeft(2, '0');
        
        double secPercent = 1 / breakTimeSecs;
        if ((percent - secPercent) > 0) {
          percent -= secPercent;
          
        } else {
          percent = 0;
        }
      });
    } else {
      _timer.cancel();
      stopwatch.stop();
    }
  }

  startTimer() {
    stopwatch.start();
    startStopwatch();
  }

  resetTimer() {
    stopwatch.reset();
    timerDisplay =
        ((breakTimeSecs / 3600).floor() % 60).toString().padLeft(2, '0') +
            ':' +
            ((breakTimeSecs / 60).floor() % 60).toString().padLeft(2, '0') +
            ':' +
            (breakTimeSecs % 60).round().toString().padLeft(2, '0');
    percent = 1;
    _timer.cancel();
  }

  pauseTimer() {
    stopwatch.stop();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        data =
            data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
      });
      print(data);
      _initalizeTimer(data);
    });
  }

  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  _initalizeTimer(data) async {
    setState(() {
      workTimeInSecs = data['timeElapsedSeconds'];
      breakTimeSecs = (workTimeInSecs / breakDivider).round();
      timerDisplay =
          ((breakTimeSecs / 3600).floor() % 60).toString().padLeft(2, '0') +
              ':' +
              ((breakTimeSecs / 60).floor() % 60).toString().padLeft(2, '0') +
              ':' +
              (breakTimeSecs % 60).round().toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // print(data);

    // setState(() {
    //   workTimeInSecs = data['timeElapsedSeconds'];
    //   breakTimeSecs = (workTimeInSecs / breakDivider).round();
    //   timerDisplay = ((breakTimeSecs * 3600) % 60).toString().padLeft(2, '0') +
    //       ':' +
    //       ((breakTimeSecs * 60) % 60).toString().padLeft(2, '0') +
    //       ':' +
    //       (breakTimeSecs % 60).toString().padLeft(2, '0');
    // });
    //Timer Functionality

    // print(workTimeInSecs);
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
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 250,
                  lineWidth: 20,
                  progressColor: Colors.cyan[600],
                  center: Text(
                    timerDisplay,
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
                                  startButton,
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  setState(() {
                                    isTimerStarted =
                                        isTimerStarted ? false : true;
                                    startButton =
                                        isTimerStarted ? 'Pause' : 'Continue';
                                    isTimerStarted
                                        ? startTimer()
                                        : pauseTimer();
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
                                color: Colors.blue[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  setState(() {
                                    resetTimer();
                                    startButton = "Continue";
                                    isTimerStarted = false;
                                  });
                                },
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
