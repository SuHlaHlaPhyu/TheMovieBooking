import 'package:flutter/material.dart';
import 'package:movie_booking/resources/dimension.dart';

class TitleText extends StatelessWidget {
  final String title;
  final Color textColor;
  final double textSize;
  TitleText(
    this.title, {
    this.textColor = Colors.black,
    this.textSize = TEXT_REGULAR_2X,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: textColor,
        fontSize: textSize,
      ),
    );
  }
}
