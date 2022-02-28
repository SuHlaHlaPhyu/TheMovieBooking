import 'package:flutter/material.dart';
import 'package:movie_booking/resources/dimension.dart';

class SubText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color textColor;
  final double textSize;
  SubText(
    this.text, {
    this.fontWeight = FontWeight.w300,
    this.textColor = Colors.black,
    this.textSize = TEXT_REGULAR,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: textSize,
      ),
    );
  }
}
