import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecontroller/services/providers.dart';
import 'package:scorecontroller/setting/timer_setting.dart';
import 'teamscore.dart';
import 'timer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                            ref.read(leftIconColorProvider.notifier).state =
                                Colors.red;
                            ref.read(rightIconColorProvider.notifier).state =
                                Colors.white;
                          },
                        ),
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
                            ref.read(leftIconColorProvider.notifier).state =
                                Colors.white;
                            ref.read(rightIconColorProvider.notifier).state =
                                Colors.red;
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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.restore),
              title: Text('Reset Timer '),
              onTap: () {
                _reset(ref);
                Navigator.pop(context);
              },
            ),
          ],
        ),
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

  void _reset(WidgetRef ref) {
    ref.read(homeTeamNameProvider.notifier).state = 'Home';
    ref.read(awayTeamNameProvider.notifier).state = 'Away';
    ref.read(leftIconColorProvider.notifier).state = Colors.red;
    ref.read(rightIconColorProvider.notifier).state = Colors.white;
  }
}
