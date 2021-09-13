import 'package:flutter/material.dart';

class Textt extends StatelessWidget {
  final String text;
  final Color color;

  Textt({required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: color,
        fontSize: 20,
        decoration: TextDecoration.none,
      ),
    );
  }
}
