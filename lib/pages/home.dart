import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color backgroundColor = Color(0xff1c243c);

  bool isTimerStarted = false;
  int tapTracker = 0;
  void _onTapped(int index) {
    setState(() {
      tapTracker++;
      if (index != 0) {
        stopTimer();
      }
    });
  }

  String hourDisplay = '0';
  String minuteDisplay = '0';
  String secondDisplay = '0';

  stopTimer() {
    goToBreak();
    isTimerStarted = isTimerStarted ? false : true;
    _timer.cancel();
  }

  //Passing data to the break page
  void goToBreak() {
    Navigator.pushReplacementNamed(context, '/break', arguments: {
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

  //Starting the stopwatch
  Timer _timer;
  startStopwatch() {
    setState(() {
      _timer = Timer(Duration(seconds: 1), keepRunning);
    });
  }

  //Callback function for the stopwatch
  keepRunning() {
    if (stopwatch.isRunning) {
      startStopwatch();
    }
    setState(() {
      hourDisplay = stopwatch.elapsed.inHours.toString();
      minuteDisplay = (stopwatch.elapsed.inMinutes % 60).toString();
      secondDisplay = (stopwatch.elapsed.inSeconds % 60).toString();
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
    hourDisplay = '0';
    minuteDisplay = '0';
    secondDisplay = '0';
    _timer.cancel();
  }

  //Pausing the stopwatch
  pauseTimer() {
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        items: [
          BottomNavigationBarItem(
            label: 'Work Mode',
            icon: Icon(
              Icons.work,
            ),
          ),
          BottomNavigationBarItem(
              label: 'Break Mode',
              icon: Icon(
                Icons.bedtime_sharp,
              ))
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[300],
        unselectedItemColor: Colors.grey[700],
        selectedLabelStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Cairo',
          letterSpacing: 4,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey[300],
          fontSize: 20,
          letterSpacing: 4,
          fontFamily: 'Cairo',
        ),
        onTap: _onTapped,
      ),
      body: Container(
        color: backgroundColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  hourDisplay,
                  style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: 75,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'hrs',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 25,
                    letterSpacing: 2,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  minuteDisplay,
                  style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: 75,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'mins',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 25,
                    letterSpacing: 2,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  secondDisplay,
                  style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: 75,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'secs',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 25,
                    letterSpacing: 2,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      isTimerStarted ? 'Pause' : "Start",
                      style: TextStyle(
                        color: Colors.amber[300],
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isTimerStarted = isTimerStarted ? false : true;
                      isTimerStarted ? startTimer() : pauseTimer();
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Colors.amber[300],
                          width: 2,
                          style: BorderStyle.solid)),
                  color: backgroundColor,
                ),
                FlatButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: isTimerStarted
                            ? Colors.grey[600]
                            : Colors.amber[300],
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  onPressed: isTimerStarted
                      ? null
                      : () {
                          setState(() {
                            resetTimer();
                          });
                        },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Colors.amber[300],
                          width: 2,
                          style: isTimerStarted
                              ? BorderStyle.none
                              : BorderStyle.solid)),
                  color: backgroundColor,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  stopTimer();
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  'Take a Break',
                  style: TextStyle(
                      color: Colors.amber[300],
                      fontFamily: 'Cairo',
                      letterSpacing: 2,
                      fontSize: 20),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: Colors.amber[300],
                      width: 2,
                      style: BorderStyle.solid)),
            )
          ],
        ),
      ),
    );
  }
}
