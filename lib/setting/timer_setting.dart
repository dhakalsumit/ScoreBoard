import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scorecontroller/home_page.dart';

import '../services/providers.dart';

class TimerSetting extends ConsumerStatefulWidget {
  const TimerSetting({super.key});

  @override
  ConsumerState<TimerSetting> createState() => _TimerSettingState();
}

class _TimerSettingState extends ConsumerState<TimerSetting> {
  late Box<String> _timerSet;
  int savedTime = 5;

  void _initializeHive() async {
    _timerSet = Hive.box<String>('timerSet');
    savedTime =
        int.tryParse(_timerSet.get('time', defaultValue: '10') ?? '10') ?? 10;
    ref.read(timerProvider.notifier).setTimer(savedTime);
    setState(() {}); // Update the UI after initializing Hive
  }

  void _updateTimerValue(int value) {
    setState(() {
      savedTime = value;
    });
    _timerSet.put('time', value.toString());
    ref.read(timerProvider.notifier).setTimer(value);
  }

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

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
                "$savedTime:00",
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
                    if (savedTime > 0) {
                      _updateTimerValue(savedTime - 1);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _updateTimerValue(savedTime + 1);
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('submitted'),
            ),
          ],
        ),
      ),
    );
  }
}
