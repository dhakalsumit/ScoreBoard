import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecontroller/services/providers.dart';

enum TeamName {
  team1,
  team2,
}

class TeamScoreWidget extends ConsumerWidget {
  final TeamName teamName;
  const TeamScoreWidget(this.teamName, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team1 = ref.watch(team1Provider);
    final team2 = ref.watch(team2Provider);
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  teamName == TeamName.team1 ? "$team1" : '$team2',
                  style: TextStyle(
                      fontSize: 100.0,
                      fontFamily: 'DigitalFont',
                      color: Colors.red),
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.yellow,
                      child: IconButton(
                        onPressed: () {
                          if (teamName == TeamName.team1) {
                            if (team1 == 0) return;
                            ref.read(team1Provider.notifier).state--;
                          } else {
                            if (team2 == 0) return;
                            ref.read(team2Provider.notifier).state--;
                          }
                        },
                        icon: Icon(Icons.remove),
                        color: Colors.black87,
                        iconSize: 40,
                      ),
                    ),
                    Container(
                      color: Colors.purple,
                      child: IconButton(
                        onPressed: () {
                          if (teamName == TeamName.team1) {
                            ref.read(team1Provider.notifier).state++;
                          } else {
                            ref.read(team2Provider.notifier).state++;
                          }
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
            SizedBox(width: 40.0),
          ],
        ),
      ],
    );
  }
}
