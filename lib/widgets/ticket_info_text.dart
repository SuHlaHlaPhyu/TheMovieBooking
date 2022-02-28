import 'package:flutter/material.dart';

class TicketInfoText extends StatelessWidget {
  final String text;
  final Color color;
  TicketInfoText(
    this.text, {
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        color: color,
      ),
    );
  }
}
