import 'package:flutter/material.dart';

class TeamScoreWidget extends StatefulWidget {
  final String initialTeamName;

  TeamScoreWidget({required this.initialTeamName});

  @override
  _TeamScoreWidgetState createState() => _TeamScoreWidgetState();
}

class _TeamScoreWidgetState extends State<TeamScoreWidget> {
  int _score = 0;

  @override
  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  void _decrementScore() {
    setState(() {
      if (_score > 0) {
        _score--;
      }
    });
  }

  void resetScore() {
    setState(() {
      _score = 0;
    });
    // Call the callback to notify parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.0),
        Row(
          children: [
            Column(
              children: [
                Text(
                  widget.initialTeamName,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'DigitalFont',
                      color: Colors.red),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementScore,
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: _incrementScore,
                      icon: Icon(
                        Icons.add,
                        size: 50,
                      ),
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 40.0),
            Text(
              '$_score',
              style: TextStyle(
                  fontSize: 130.0,
                  fontFamily: 'DigitalFont',
                  color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
