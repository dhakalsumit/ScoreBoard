import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecontroller/services/api_services.dart';
import 'package:scorecontroller/services/providers.dart';
import 'package:scorecontroller/setting/ip_config.dart';
import 'package:scorecontroller/setting/timer_setting.dart';
import 'teamscore.dart';
import 'timer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Reset orientation back to portrait for other screens
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeTeamName = ref.watch(homeTeamNameProvider);
    final awayTeamName = ref.watch(awayTeamNameProvider);
    final leftIconColor = ref.watch(leftIconColorProvider);
    final rightIconColor = ref.watch(rightIconColorProvider);

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
                          onPressed: () => _showRegisterDialog(
                              context, ref, homeTeamNameProvider, 'Home'),
                          child: Text(
                            homeTeamName,
                            style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'DigitalFont',
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_left,
                              color: leftIconColor,
                              size: 50,
                            ),
                            onPressed: () {
                              _toggleSide(context, 'left');
                            }),
                      ],
                    ),
                    TimerScreen(),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => _showRegisterDialog(
                              context, ref, awayTeamNameProvider, 'Away'),
                          child: Text(
                            awayTeamName,
                            style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'DigitalFont',
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            color: rightIconColor,
                            size: 50,
                          ),
                          onPressed: () {
                            _toggleSide(context, 'right');
                          },
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
                  TeamScoreWidget(
                    TeamName.team1,
                  ),
                  TeamScoreWidget(
                    TeamName.team2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(bottom: 0, top: 0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IPConfigScreen()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(timerProvider.notifier).resetTimer();
          ref.read(team1Provider.notifier).state = 0;
          ref.read(team2Provider.notifier).state = 0;
        },
        child: Icon(Icons.restore),
        backgroundColor: Colors.blue.shade900,
      ),
    );
  }

  void _showRegisterDialog(BuildContext context, WidgetRef ref,
      StateProvider<String> teamNameProvider, String teamType) {
    final TextEditingController controller = TextEditingController();
    controller.text = ref.read(teamNameProvider);

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
                ref.read(teamNameProvider.notifier).state = controller.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleSide(BuildContext context, String side) {
    final leftIconColor = ref.read(leftIconColorProvider);
    final rightIconColor = ref.read(rightIconColorProvider);

    if (side == 'left') {
      ref.read(leftIconColorProvider.notifier).state = Colors.red;
      ref.read(rightIconColorProvider.notifier).state = Colors.white;
      ApiService().toggleButton('left');
    } else {
      ref.read(leftIconColorProvider.notifier).state = Colors.white;
      ref.read(rightIconColorProvider.notifier).state = Colors.red;
      ApiService().toggleButton('right');
    }
  }
}
