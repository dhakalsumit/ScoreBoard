import 'package:flutter/material.dart';

class TeamName extends StatefulWidget {
  const TeamName({super.key});

  @override
  State<TeamName> createState() => _TeamNameState();
}

class _TeamNameState extends State<TeamName> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Register Team Name'),
      content: TextField(
        decoration: InputDecoration(hintText: 'Enter team name'),
      ),
    );
  }
}
