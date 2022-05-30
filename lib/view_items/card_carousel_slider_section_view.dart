import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/view_items/payment_cart_view.dart';

import '../data/vos/user_card_vo.dart';
import '../resources/dimension.dart';

class CardCarouselSliderSectionView extends StatelessWidget {
  Function(int?) onTap;
  List<UserCardVO>? cardList;
  CardCarouselSliderSectionView({required this.onTap, required this.cardList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          // cardId = cardList?[index].id ?? 682;
          onTap(index);
        },
        height: BARCODE_WIDTH,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: cardList
              ?.map(
                (card) => PaymentCardView(card),
              )
              .toList() ??
          [],
    );
  }
}
