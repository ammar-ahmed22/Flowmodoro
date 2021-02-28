import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color backgroundColor = Color(0xff1c243c);

  double breakDividerVal = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                'Set Break Duration Here',
                style: TextStyle(
                    fontSize: 45,
                    letterSpacing: 2,
                    color: Colors.amber[300],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 25,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(text: 'Amount of Time Worked Is Divided By '),
                    TextSpan(text: '${breakDividerVal.round()} ', style: TextStyle(color: Colors.amber[400], fontSize: 30)),
                    TextSpan(text: 'To Get The Break Duration')
                  ]
                ),
              ),

              
              SliderTheme(
                data: SliderThemeData(
                    activeTrackColor: Colors.amber[300],
                    inactiveTrackColor: Colors.amber[100],
                    thumbColor: Colors.amber[700],
                    overlayColor: Colors.amberAccent[100],
                    showValueIndicator: ShowValueIndicator.never,
                    trackHeight: 6),
                child: Slider(
                  value: breakDividerVal,
                  onChanged: (newVal) {
                    setState(() {
                      breakDividerVal = newVal;
                    });
                  },
                  min: 1,
                  max: 9,
                  divisions: 8,
                  label: '${breakDividerVal.round()}',
                ),
              ),
              SizedBox(height: 40,),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, {'breakDivider': breakDividerVal});
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.amber[300],
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                  ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Colors.amber[300],
                    width: 2,
                    style: BorderStyle.solid
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
