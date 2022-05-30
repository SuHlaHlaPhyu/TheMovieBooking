import 'package:flutter/material.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/configs/environment_config.dart';

import '../data/vos/user_card_vo.dart';
import '../resources/color.dart';
import '../resources/dimension.dart';
import 'card_sub_text.dart';
import 'cart_title_text.dart';

class PaymentCardView extends StatelessWidget {
  final UserCardVO cardInfo;
  PaymentCardView(this.cardInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        MARGIN_MEDIUM_3,
      ),
      height: BARCODE_WIDTH,
      //width: double.infinity,
      width: 320,
      decoration: BoxDecoration(
        border: cardInfo.isSelected == true? Border.all(
          color: Colors.yellow,
          width: 3,
        ) : null,
        gradient: LinearGradient(
          colors: [
            // PAYMENT_CARD_COLOR,
            // PRIMARY_COLOR,
            CARD_COLOR[EnvironmentConfig.CONFIG_FIRST_CARD_COLOR],
            CARD_COLOR[EnvironmentConfig.CONFIG_SECOND_CARD_COLOR]
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(
          MARGIN_MEDIUM,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardInfo.cardType ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_HEADING_1X,
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: Text(
              cardInfo.cardNumber ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_3X,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitleText('CARD HOLDER'),
                  CardSubText(cardInfo.cardHolder ?? ""),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitleText('EXPIRES'),
                  CardSubText(cardInfo.expirationDate ?? ""),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
