import 'package:flutter/material.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';

import 'sub_text.dart';

class AppIconTextButton extends StatelessWidget {
  final String btnText;
  final String image;
  final Color btnColor;
  final Color textColor;
  AppIconTextButton(
    this.btnText,
    this.image, {
    this.btnColor = PRIMARY_COLOR,
    this.textColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(5),
        color: btnColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: 13.0,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM_3,
          ),
          SubText(
            btnText,
            textColor: textColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
