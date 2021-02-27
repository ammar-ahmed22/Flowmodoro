import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';

class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  Color backgroundColor = Color(0xff1c243c);

  String hourDisplay = '0';
  String minuteDisplay = '0';
  String secondDisplay = '0';

  bool isTimerStarted = false;

  void _onTapped(int index) {
    print(index);
    if (index != 1) {
      stopTimer();
    }
  }

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

  Map data = {};
  double percent =
      1; // Intial percentage for countdown is 100% (incremented down)
  int breakDivider =
      5; //Amount which the work time is divided by to get break time (will be customizable)
  int workTimeInSecs; //Amount of time that work was done for (from home page)
  Timer _timer; // Timer object
  String timerDisplay = '00:00:00'; //Inital string for timer display
  int breakTimeSecs; //Amount of time the break will be

  int displayTimeSecs;

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
        //Sets the timer display using the same difference (converting secs to hours - elapsed hours)
        displayTimeSecs = breakTimeSecs;

        displayTimeSecs -= stopwatch.elapsed.inSeconds;


        hourDisplay = (displayTimeSecs / 3600).floor().toString();
        minuteDisplay = ((displayTimeSecs / 60).floor() % 60).toString();
        secondDisplay = (displayTimeSecs % 60).toString();

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
    hourDisplay = ((breakTimeSecs / 3600).floor() % 60).toString();
    minuteDisplay = ((breakTimeSecs / 60).floor() % 60).toString();
    secondDisplay = (breakTimeSecs % 60).round().toString();
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

  _initalizeTimer(data) async {
    setState(() {
      workTimeInSecs = data['timeElapsedSeconds'];
      breakTimeSecs = (workTimeInSecs / breakDivider).round();
      hourDisplay = ((breakTimeSecs / 3600).floor() % 60).toString();
      minuteDisplay = ((breakTimeSecs / 60).floor() % 60).toString();
      secondDisplay = (breakTimeSecs % 60).round().toString();
    });
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
        currentIndex: 1,
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
            CircularPercentIndicator(
              percent: percent,
              animateFromLastPercent: true,
              animation: true,
              radius: 350,
              lineWidth: 5,
              progressColor: Colors.amber[300],
              center: Row(
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
