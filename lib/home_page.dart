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
  final _homeTeamNameController = TextEditingController();
  final _awayTeamNameController = TextEditingController();
  String _homeTeamName = 'Home';
  String _awayTeamName = 'Away';

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

  void _showRegisterDialog(TextEditingController controller, String teamType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Register $teamType Team Name'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter team name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Register'),
              onPressed: () {
                setState(() {
                  if (teamType == 'Home') {
                    _homeTeamName = controller.text;
                  } else {
                    _awayTeamName = controller.text;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _showRegisterDialog(
                                _homeTeamNameController, 'Home');
                          },
                          child: Text(
                            _homeTeamName,
                            style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'DigitalFont',
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_left,
                            color: _leftIconColor,
                            size: 50,
                          ),
                          onPressed: _toggleLeftIcon,
                        ),
                      ],
                    ),
                    TimerScreen(),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _showRegisterDialog(
                                _awayTeamNameController, 'Away');
                          },
                          child: Text(
                            _awayTeamName,
                            style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'DigitalFont',
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            color: _rightIconColor,
                            size: 50,
                          ),
                          onPressed: _toggleRightIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TeamScoreWidget(),
                  TeamScoreWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
