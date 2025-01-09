import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive_flutter/hive_flutter.dart';

final homeTeamNameProvider = StateProvider<String>((ref) => 'Home');
final awayTeamNameProvider = StateProvider<String>((ref) => 'Away');

final leftIconColorProvider = StateProvider<Color>((ref) => Colors.red);
final rightIconColorProvider = StateProvider<Color>((ref) => Colors.white);

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier()
      : super(60 *
            (int.tryParse(Hive.box<String>('timerSet')
                        .get('time', defaultValue: '10') ??
                    '10') ??
                10)); // yo super vaneko inherit gareko ho stateNotifier ko constructor lai call gareko ho
  // yesari suru ma hive bata herne kei time xa vane tei gardine state lai navaye 10 min default set hunxa

  Timer? _timer;

  Future<void> setTimer(int minutes) async {
    state = minutes * 60;
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer!.cancel();
      }
    });
  }

  void resetTimer() {
    final box = Hive.box<String>('timerSet');
    state =
        60 * (int.tryParse(box.get('time', defaultValue: '10') ?? '10') ?? 10);
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final team1Provider = StateProvider<int>((ref) {
  return 0;
});

final team2Provider = StateProvider<int>((ref) {
  return 0;
});
