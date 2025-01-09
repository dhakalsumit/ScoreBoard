import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorecontroller/home_page.dart';
import 'package:scorecontroller/setting/ip_config.dart';
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.blue.shade900,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: double.maxFinite,
                  child: Image.network(
                      "https://t3.ftcdn.net/jpg/02/12/94/08/360_F_212940896_KqWDiNF4YRZARWSfgZlRJi9BpB3E5WwF.jpg")),
              SizedBox(
                height: 200,
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Click here',
                          style: TextStyle(
                              fontFamily: 'DigitalFont',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade900,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
