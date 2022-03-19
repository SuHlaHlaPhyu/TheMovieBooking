import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/voucher_bloc.dart';
import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/network/api_constants.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/widgets/ticket_info_row.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class TicketInfoPage extends StatelessWidget {
  MovieVO movieVO;
  CheckoutVO checkoutVO;
  TicketInfoPage({Key? key, required this.checkoutVO, required this.movieVO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VoucherBloc(movieVO, checkoutVO),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              _navigateToHomeScreen(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TitleView(),
                const SizedBox(
                  height: MARGIN_SMALL_2,
                ),
                Selector<VoucherBloc, MovieVO?>(
                    selector: (BuildContext context, bloc) => bloc.movieVO,
                    builder: (BuildContext context, movieVO, Widget? child) {
                      return MovieNameCardView(
                        movieVO: movieVO,
                      );
                    }),
                Selector<VoucherBloc, CheckoutVO?>(
                    selector: (BuildContext context, bloc) => bloc.checkoutVO,
                    builder: (BuildContext context, checkoutVO, Widget? child) {
                      return TicketInfoCard(
                        checkoutVO: checkoutVO,
                      );
                    }),
                Card(
                  elevation: 0.0,
                  child: Container(
                    height: BARCODE_CARD_HEIGHT,
                    margin: const EdgeInsets.all(
                      MARGIN_MEDIUM_2,
                    ),
                    child: BarcodeWidget(
                      width: BARCODE_WIDTH,
                      height: BARCODE_HEIGHT,
                      barcode: Barcode.code128(),
                      data: checkoutVO.qrCode ?? "",
                      drawText: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _navigateToHomeScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
}

class TicketInfoCard extends StatelessWidget {
  CheckoutVO? checkoutVO;
  TicketInfoCard({required this.checkoutVO});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        margin: const EdgeInsets.all(
          MARGIN_MEDIUM_2,
        ),
        width: double.infinity,
        height: HOME_SCREEN_MOVIE_HEIGHT,
        child: Column(
          children: [
            TicketInfoRow(
              'Booking No',
              checkoutVO?.bookingNo ?? "",
            ),
            const Spacer(),
            TicketInfoRow(
              'Show time - Date',
              " ${checkoutVO?.timeslot!.startTime} - ${checkoutVO?.bookingDate}",
            ),
            const Spacer(),
            TicketInfoRow(
              'Theater',
              'Galaxy cinema - Golden City',
            ),
            const Spacer(),
            TicketInfoRow(
              'Screen',
              '2',
            ),
            const Spacer(),
            TicketInfoRow(
              'Row',
              checkoutVO?.row ?? "",
            ),
            const Spacer(),
            TicketInfoRow(
              'Seats',
              checkoutVO?.seat ?? "",
            ),
            const Spacer(),
            TicketInfoRow(
              'Price',
              checkoutVO?.total ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

class MovieNameCardView extends StatelessWidget {
  MovieVO? movieVO;
  MovieNameCardView({required this.movieVO});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
          MARGIN_MEDIUM_2,
        )),
        width: double.infinity,
        height: HOME_SCREEN_MOVIE_HEIGHT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: BARCODE_WIDTH,
              width: double.infinity,
              child: Image.network(
                "$IMAGE_BASE_URL${movieVO?.posterPath}",
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2,
              ),
              child: Text(
                movieVO?.title ?? "",
                style: const TextStyle(
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: MARGIN_SMALL_2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2,
              ),
              child: Text(
                '105m - IMAX',
                style: TextStyle(
                  fontSize: TEXT_REGULAR_1X,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: MARGIN_SMALL_2,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Awesome!',
          style: TextStyle(
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'This is your ticket',
          style: TextStyle(
            fontSize: TEXT_REGULAR_2X,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
