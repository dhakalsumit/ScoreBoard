import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

// Team Name Providers
final homeTeamNameProvider = StateProvider<String>((ref) => 'Home');
final awayTeamNameProvider = StateProvider<String>((ref) => 'Away');

// Icon Color Providers
final leftIconColorProvider = StateProvider<Color>((ref) => Colors.red);
final rightIconColorProvider = StateProvider<Color>((ref) => Colors.white);

// Timer Provider
final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(10 * 60); // Initial state is 10 minutes in seconds

  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playTickSound() async {
    await _audioPlayer.play(AssetSource('assets/music/tick.mp3'));
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
        _playTickSound();
      } else {
        _timer!.cancel();
      }
    });
  }

  void resetTimer() {
    state = 10 * 60; // Reset to 10 minutes
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}


