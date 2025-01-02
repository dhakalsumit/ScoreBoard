import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerSetting extends ConsumerStatefulWidget {
  const TimerSetting({super.key});

  @override
  ConsumerState<TimerSetting> createState() => _TimerSettingState();
}

class _TimerSettingState extends ConsumerState<TimerSetting> {
  int _currentMinutes = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "$_currentMinutes:00",
                style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DigitalFont',
                    color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_currentMinutes > 0) {
                        _currentMinutes--;
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _currentMinutes++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
