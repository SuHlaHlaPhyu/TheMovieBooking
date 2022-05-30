import 'package:flutter/material.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/view_items/payment_cart_view.dart';

class CardHorizontalListView extends StatelessWidget {
  Function(int?) onTap;
  List<UserCardVO>? cardList;
  CardHorizontalListView({required this.onTap, required this.cardList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      height: HORIZONTAL_CARD_LISTVIEW_HEIGHT,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: MARGIN_MEDIUM,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: cardList?.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  onTap(index);
                },
                child: PaymentCardView(
                  cardList![index],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
