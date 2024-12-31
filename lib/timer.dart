import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _remainingTime = 10 * 60; // 10 minutes in seconds
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Function to play the tick sound
  Future<void> _playTickSound() async {
    await _audioPlayer.play(AssetSource('assets/music/tick.mp3')); 
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _playTickSound(); // Play the tick sound every second
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _remainingTime = 10 * 60; // Reset to 10 minutes
    });
    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startTimer,
      child: Text(
        _formatTime(_remainingTime),
        style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            fontFamily: 'DigitalFont',
            color: Colors.white),
      ),
    );
  }
}
