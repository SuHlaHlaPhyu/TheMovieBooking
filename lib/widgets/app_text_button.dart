import 'package:flutter/material.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/configs/environment_config.dart';
import 'package:movie_booking/resources/color.dart';

import 'sub_text.dart';

class AppTextButton extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final bool isBorder;
  AppTextButton(
    this.btnText, {
    this.btnColor = PRIMARY_COLOR,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        border: isBorder
            ? Border.all(
                color: Colors.grey,
              )
            : null,
        borderRadius: BorderRadius.circular(5),
        color: btnColor,
      ),
      child: Center(
        child: SubText(
          btnText,
          textColor: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
