import 'package:flutter/material.dart';

import '../resources/dimension.dart';
class CardSubText extends StatelessWidget {
  final String text;
  CardSubText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}