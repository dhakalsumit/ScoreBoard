import 'package:flutter/material.dart';
import 'package:scorecontroller/timer.dart';

class TimerSetting extends StatefulWidget {
  const TimerSetting({super.key});

  @override
  _TimerSettingState createState() => _TimerSettingState();
}

class _TimerSettingState extends State<TimerSetting> {
  late TimerScreenState timerScreenState;
  int _remainingTime = 10 * 60;

  void incrementTime() {
    setState(() {
      _remainingTime += 60;
    });
  }

  void decrementTime() {
    setState(() {
      if (_remainingTime > 60) {
        _remainingTime -= 60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Timer Settings', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Timer',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            '${_remainingTime ~/ 60} min',
            style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: 'DigitalFont',
                color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.purple,
                child: IconButton(
                  onPressed: () {
                    decrementTime();
                  },
                  icon: Icon(
                    Icons.remove,
                    size: 40,
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 40.0),
              Container(
                color: Colors.red,
                child: IconButton(
                  onPressed: () {
                    incrementTime();
                  },
                  icon: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
