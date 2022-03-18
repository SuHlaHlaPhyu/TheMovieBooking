import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/card_bloc.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
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
  // AuthModel authModel = AuthModelImpl();
  // List<UserCardVO>? cardList;
  // CheckOutRequest? checkOutRequest;
  //CheckoutVO? checkoutVO;
  late CardBloc bloc;
  int cardId = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bloc = Provider.of<CardBloc>(context, listen: false);
    });

    super.initState();
  }

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
                    return CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          cardId = cardList?[index].id ?? 0;
                        },
                        height: BARCODE_WIDTH,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: cardList
                          ?.map(
                            (card) => PaymentCardView(card),
                          )
                          .toList(),
                    );
                  }),
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            left: MARGIN_XLARGE,
          ),
          child: GestureDetector(
            onTap: () {
              goToNextPage(context);
            },
            child: AppTextButton(
              "Confrim",
            ),
          ),
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context) {
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
    bloc.sendCheckoutRequest(checkOutRequest).then((value) {
      _navigateToTicketInfoPage(context, value, widget.movie);
    });
    // authModel.checkout(checkOutRequest).then((value) {
    //   setState(() {
    //     checkoutVO = value!;
    //   });
    //   _navigateToTicketInfoPage(context, checkoutVO!, widget.movie);
    // });
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
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            PAYMENT_CARD_COLOR,
            PRIMARY_COLOR,
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
