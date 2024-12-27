import 'package:flutter/material.dart';
import 'package:scorecontroller/teamscore.dart';
import 'package:scorecontroller/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _leftIconColor = Colors.red;
  Color _rightIconColor = Colors.white;

  void _toggleLeftIcon() {
    setState(() {
      _leftIconColor = Colors.red;
      _rightIconColor = Colors.white;
    });
  }

  void _toggleRightIcon() {
    setState(() {
      _leftIconColor = Colors.white;
      _rightIconColor = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Arrow",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_left,
                        color: _leftIconColor,
                        size: 50,
                      ),
                      onPressed: () {
                        _toggleLeftIcon();
                      },
                    )
                  ],
                ),
                TimerScreen(),
                Column(
                  children: [
                    Text(
                      "Arrow",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: _rightIconColor,
                        size: 50,
                      ),
                      onPressed: () {
                        _toggleRightIcon();
                      },
                    ),
                  ],
                ),
              ],
            ),
            Container(
                height: 200,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TeamScoreWidget(initialTeamName: "Home"),
                    TeamScoreWidget(initialTeamName: "Away"),
                  ],
                ))
          ],
        ));
  }
}
