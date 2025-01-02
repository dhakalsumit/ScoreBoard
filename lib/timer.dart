import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecontroller/services/providers.dart';


class TimerScreen extends ConsumerWidget {
  const TimerScreen({Key? key}) : super(key: key);

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    return GestureDetector(
      onTap: timerNotifier.startTimer,
      child: Text(
        _formatTime(remainingTime),
        style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            fontFamily: 'DigitalFont',
            color: Colors.white),
      ),
    );
  }
}
