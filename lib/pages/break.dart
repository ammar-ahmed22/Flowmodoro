import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  // object for incoming data from home page
  Map data = {};

  // initial button strings
  String switchButton = 'Stop working';
  String startButton = 'Start Break';

  //bool for updating whether timer is started or not
  bool isTimerStarted = false;

  // Function that is called when want to go back to work
  stopTimer() {
    goBackToWork();
    stopwatch.stop();
    dispose();
  }

  // Function that takes back to the home page
  void goBackToWork() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  double percent =
      1; // Intial percentage for countdown is 100% (incremented down)
  int breakDivider =
      5; //Amount which the work time is divided by to get break time (will be customizable)
  int workTimeInSecs; //Amount of time that work was done for (from home page)
  Timer _timer; // Timer object
  String timerDisplay = '00:00:00'; //Inital string for timer display
  int breakTimeSecs; //Amount of time the break will be

  var stopwatch = Stopwatch(); //Stopwatch object

  // Function that calls the timer object to start counting
  startStopwatch() {
    setState(() {
      //Callback function keeps the timer running recursively
      _timer = Timer(Duration(seconds: 1), keepRunning);
    });
  }

  //Callback function for timer in startStopwatch()
  keepRunning() {
    //Checks if stopwatch is running ? calls startStopwatch() again (allows this to keep going unless stopwatch is stopped)
    if (stopwatch.isRunning) {
      startStopwatch();
    }

    //Stopwatch timer going up but we want time to count down
    //break time is constant, so, as long as the difference is greater than zero
    //there is still time remaining
    if ((breakTimeSecs - stopwatch.elapsed.inSeconds) >= 0) {
      setState(() {
        //Sets the timerdisplay using the same difference (converting secs to hours - elapsed hours)
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

        // Fraction of the whole that needs to be decremented from the whole
        // to update the circle indicator
        double secPercent = 1 / breakTimeSecs;

        //Ensuring we don't get a negative percent value (will break the app)
        if ((percent - secPercent) > 0) {
          // As long as the percent indicator is positive there is time rem
          percent -= secPercent;
        } else {
          //Now it is negative, time is up. Therefore, percent is 0
          percent = 0;
        }
      });
    } else {
      // No more time remaining (breakTime - elapsed <= 0)
      _timer.cancel();
      stopwatch.stop();
      isTimerStarted = false;
    }
  }

  // Function that is used in the start button
  startTimer() {
    stopwatch.start();
    startStopwatch();
  }

  //Resetting the timer
  resetTimer() {
    stopwatch.reset();

    //Timer display reinitialized to the break time based on home page and break divider
    timerDisplay =
        ((breakTimeSecs / 3600).floor() % 60).toString().padLeft(2, '0') +
            ':' +
            ((breakTimeSecs / 60).floor() % 60).toString().padLeft(2, '0') +
            ':' +
            (breakTimeSecs % 60).round().toString().padLeft(2, '0');
    percent = 1;

    // cancelling the timer to not cause infinite loops and continously running timers
    _timer.cancel();
  }

  // pauses the timer
  pauseTimer() {
    stopwatch.stop();
  }

  @override

  // Called on the initial build of the page
  void initState() {
    super.initState();

    // Gives the impression of a future to get the data.
    Future.delayed(Duration.zero, () {
      setState(() {
        data =
            data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
      });
      print(data);

      // Function that sets the data in the right variables
      _initalizeTimer(data);
    });
  }

  // Disposal of the timer when going back to the home page or any other pages
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
                          onPressed: isTimerStarted
                              ? null
                              : () {
                                  setState(() {
                                    goBackToWork();
                                  });
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
