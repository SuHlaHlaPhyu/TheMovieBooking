import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/card_bloc.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/configs/environment_config.dart';
import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/network/checkout_request.dart';
import 'package:movie_booking/network/snack_request.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:provider/provider.dart';

import '../view_items/card_carousel_slider_section_view.dart';
import '../view_items/card_horizontal_list_view.dart';
import 'add_new_card_page.dart';
import 'ticket_info_page.dart';

class PaymentInfoPage extends StatefulWidget {
  MovieVO movie;
  String date;
  String time;
  String cinemaName;
  CinemaVO cinema;
  String row;
  String seat;
  double? totalCost;
  int timeslot;
  List<SnackRequest> snackrequest;
  PaymentInfoPage({
    Key? key,
    required this.movie,
    required this.date,
    required this.time,
    required this.cinemaName,
    required this.cinema,
    required this.row,
    required this.seat,
    this.totalCost,
    required this.timeslot,
    required this.snackrequest,
  }) : super(key: key);

  @override
  _PaymentInfoPageState createState() => _PaymentInfoPageState();
}

class _PaymentInfoPageState extends State<PaymentInfoPage> {
  int cardId = 682;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentAmountView(
                totalCost: widget.totalCost ?? 0.0,
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              Selector<CardBloc, List<UserCardVO>?>(
                selector: (BuildContext context, bloc) => bloc.cardList,
                builder: (BuildContext context, cardList, Widget? child) {
                  return USER_CARD[EnvironmentConfig.CONFIG_USER_CARD] ==
                          "Horizontal list"
                      ? CardHorizontalListView(
                          onTap: (index) {
                            cardId = cardList?[index ?? 0].id ?? 682;
                            setState(() {
                              cardList
                                  ?.map((e) => e.isSelected = false)
                                  .toList();
                              cardList?[index ?? 0].isSelected = true;
                            });
                          },
                          cardList: cardList ?? [],
                        )
                      : CardCarouselSliderSectionView(
                          onTap: (index) {
                            cardId = cardList?[index ?? 0].id ?? 682;
                          },
                          cardList: cardList ?? [],
                        );
                },
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              AddNewCardView(
                () {
                  _navigateToAddNewCardPage(context);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Selector<CardBloc, CheckoutVO?>(
          selector: (BuildContext context, bloc) => bloc.checkoutVO,
          builder: (BuildContext context, value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(
                left: MARGIN_XLARGE,
              ),
              child: GestureDetector(
                onTap: () {
                  CardBloc bloc = Provider.of<CardBloc>(context, listen: false);
                  goToNextPage(context, bloc);
                },
                child: AppTextButton(
                  "Confirm",
                  btnColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context, CardBloc bloc) {
    CheckOutRequest checkOutRequest = CheckOutRequest(
        widget.timeslot,
        widget.seat,
        widget.date,
        widget.movie.id ?? 568124,
        cardId,
        widget.snackrequest,
        widget.cinema.cinemaId ?? 1,
        widget.row,
        widget.totalCost ?? 0.0);
    bloc
        .sendCheckoutRequest(checkOutRequest, widget.movie)
        .then((checkoutRequest) {
      _navigateToTicketInfoPage(context, checkoutRequest, widget.movie);
    });
  }
}

void _navigateToAddNewCardPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddNewCardPage(),
    ),
  );
}

void _navigateToTicketInfoPage(
    BuildContext context, CheckoutVO checkoutVO, MovieVO movieVO) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TicketInfoPage(
        checkoutVO: checkoutVO,
        movieVO: movieVO,
      ),
    ),
  );
}

class AddNewCardView extends StatelessWidget {
  final Function onTapNewCard;
  AddNewCardView(this.onTapNewCard);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.add_circle,
          color: GREEN_COLOR,
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        GestureDetector(
          onTap: () {
            onTapNewCard();
          },
          child: const Text(
            'Add new card',
            style: TextStyle(
              color: GREEN_COLOR,
            ),
          ),
        )
      ],
    );
  }
}

class PaymentAmountView extends StatelessWidget {
  double totalCost;
  PaymentAmountView({required this.totalCost});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Payment amount',
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          '\$ $totalCost',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_HEADING_3X,
          ),
        ),
      ],
    );
  }
}
