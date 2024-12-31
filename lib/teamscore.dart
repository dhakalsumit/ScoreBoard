import 'package:flutter/material.dart';

class TeamScoreWidget extends StatefulWidget {
  const TeamScoreWidget({super.key});

  @override
  _TeamScoreWidgetState createState() => _TeamScoreWidgetState();
}

class _TeamScoreWidgetState extends State<TeamScoreWidget> {
  int _score = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  '$_score',
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
                        onPressed: _decrementScore,
                        icon: Icon(Icons.remove),
                        color: Colors.black87,
                        iconSize: 40,
                      ),
                    ),
                    Container(
                      color: Colors.purple,
                      child: IconButton(
                        onPressed: _incrementScore,
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
