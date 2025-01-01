import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorecontroller/setting/timer_setting.dart';

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

  // final GlobalKey<_TimerScreenState> _timerKey = GlobalKey<_TimerScreenState>();
  // final GlobalKey<_TeamScoreWidgetState> _homeScoreKey =
  //     GlobalKey<_TeamScoreWidgetState>();
  // final GlobalKey<_TeamScoreWidgetState> _awayScoreKey =
  //     GlobalKey<_TeamScoreWidgetState>();
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

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

  void _reset() {
    setState(() {
      _homeTeamName = 'Home';
      _awayTeamName = 'Away';
      _leftIconColor = Colors.red;
      _rightIconColor = Colors.white;
      _homeTeamNameController.clear();
      _awayTeamNameController.clear();
    });
    // _timerKey.currentState?.resetTimer();
    // _homeScoreKey.currentState?.resetScore();
    // _awayScoreKey.currentState?.resetScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     Builder(
      //       builder: (context) => IconButton(
      //         icon: Icon(
      //           Icons.settings,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       ),
      //     ),
      //   ],
      // ),
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
                            _homeTeamNameController.text = _homeTeamName;
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
                            _awayTeamNameController.text = _awayTeamName;
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Text("Hello Arrav dai"),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text('Change time '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerSetting()),
                );
              },
            ),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text('Ip Configure '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.restore),
              title: Text('Reset Timer '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => SettingPage()),
      //     );
      //   },
      //   backgroundColor: Colors.transparent,
      //   child: IconButton(
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       icon: const Icon(
      //         Icons.reset_tv,
      //         color: Colors.white,
      //       )),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
