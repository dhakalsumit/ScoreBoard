import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorecontroller/home_page.dart';
import 'package:scorecontroller/setting/timer_setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Score Controller',
          style: TextStyle(
              fontFamily: 'DigitalFont',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: Icon(
          Icons.scoreboard_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Image.network(
                        "https://t3.ftcdn.net/jpg/02/12/94/08/360_F_212940896_KqWDiNF4YRZARWSfgZlRJi9BpB3E5WwF.jpg")),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text('Timer Settings',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerSetting()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Ip Configure',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerSetting()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
