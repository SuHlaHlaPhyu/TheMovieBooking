import 'package:flutter/material.dart';

import '../resources/dimension.dart';

class CardTitleText extends StatelessWidget {
  final String text;
  CardTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}