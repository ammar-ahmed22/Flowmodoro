import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Color backgroundColor = Color(0xff1c243c);
  Color cardBackColor = Color(0xff292e3d);

  double breakDividerVal = 5;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.amber[300],
            ),
            onPressed: () {
              Navigator.pop(context, {
                'breakDivider': breakDividerVal
              });
            },
          ),
          iconTheme: IconThemeData(color: Colors.amber[300]),
          backgroundColor: backgroundColor,
          title: Text(
            'Menu',
            style: TextStyle(
                fontSize: 25, color: Colors.amber[300], letterSpacing: 2),
          ),
          elevation: 0,
        ),
        body: Container(
          color: backgroundColor,
          width: double.infinity,
          child: Column(
            children: [
              Card(
                color: backgroundColor,
                elevation: 0,
                shape: Border(
                    top: BorderSide(color: Colors.amber[300]),
                    bottom: BorderSide(color: Colors.amber[300])),
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    'What is Flowmodoro?',
                    style: TextStyle(color: Colors.amber[300], fontSize: 25),
                  ),
                  trailing: Icon(
                    Icons.info_outline,
                    color: Colors.amber[300],
                  ),
                ),
              ),
              Card(
                color: backgroundColor,
                elevation: 0,
                shape: Border(
                    top: BorderSide(color: Colors.amber[300]),
                    bottom: BorderSide(color: Colors.amber[300])),
                child: ListTile(
                  onTap: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/settings');
                    setState(() {
                      breakDividerVal =
                          (result == null) ? 5 : result['breakDivider'];
                    });
                  },
                  title: Text(
                    'Set Break Durations',
                    style: TextStyle(color: Colors.amber[300], fontSize: 25),
                  ),
                  trailing: Icon(
                    Icons.settings,
                    color: Colors.amber[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
