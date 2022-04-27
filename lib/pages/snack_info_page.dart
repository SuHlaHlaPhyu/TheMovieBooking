import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/snack_payment_bloc.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/network/snack_request.dart';
import 'package:movie_booking/pages/payment_info_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:provider/provider.dart';

class SnackInfoPage extends StatelessWidget {
  MovieVO? movieName;
  final String date;
  String? time;
  String? cinemaName;
  CinemaVO cinema;
  double totalCost;
  String row;
  String seat;
  int timeslot;
  SnackInfoPage(
      {Key? key,
      required this.movieName,
      required this.date,
      required this.time,
      required this.cinemaName,
      required this.cinema,
      required this.totalCost,
      required this.row,
      required this.seat,
      required this.timeslot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnackPaymentBloc(),
      child: Selector<SnackPaymentBloc, List<PaymentVO>?>(
          selector: (BuildContext context, bloc) => bloc.paymentList,
          builder: (BuildContext context, value, Widget? child) {
            SnackPaymentBloc bloc =
                Provider.of<SnackPaymentBloc>(context, listen: false);
            return Scaffold(
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Selector<SnackPaymentBloc, List<SnackVO>>(
                        shouldRebuild: (previous, next) => previous != next,
                        selector: (BuildContext context, bloc) =>
                            bloc.snackList,
                        builder:
                            (BuildContext context, snackList, Widget? child) {
                          SnackPaymentBloc bloc = Provider.of<SnackPaymentBloc>(
                              context,
                              listen: false);
                          return SnackInfoListView(
                            snackList: snackList,
                            onAdded: (index) {
                              bloc.addQuantity(snackList[index]);
                            },
                            onRemoved: (index) {
                              bloc.subtractQuantity(snackList[index]);
                            },
                          );
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Selector<SnackPaymentBloc, double>(
                        selector: (BuildContext context, bloc) =>
                            bloc.grandTotal,
                        builder:
                            (BuildContext context, grandTotal, Widget? child) {
                          return PromoTextFormView(
                            totalCost: grandTotal,
                          );
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Selector<SnackPaymentBloc, List<PaymentVO>?>(
                        shouldRebuild: (previous, next) => previous != next,
                        selector: (BuildContext context, bloc) =>
                            bloc.paymentList,
                        builder:
                            (BuildContext context, paymentList, Widget? child) {
                          SnackPaymentBloc bloc = Provider.of<SnackPaymentBloc>(
                              context,
                              listen: false);
                          return PaymentMethodView(
                            paymentList: paymentList ?? [],
                            selectedPayment: (selectIndex) {
                              bloc.selectedPaymentMethods(selectIndex);
                            },
                          );
                        }),
                    const SizedBox(
                      height: 200.0,
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                key: const ValueKey("pay"),
                padding: const EdgeInsets.only(
                  left: 30.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    goToNextPage(context, bloc);
                  },
                  child: Selector<SnackPaymentBloc, double>(
                      selector: (BuildContext context, bloc) => bloc.grandTotal,
                      builder:
                          (BuildContext context, grandTotal, Widget? child) {
                        return Selector<SnackPaymentBloc, String>(
                            selector: (BuildContext context, bloc) =>
                                bloc.selectPayment,
                            builder: (BuildContext context, selectPayment,
                                Widget? child) {
                              return AppTextButton(
                                "Pay \$ $grandTotal",
                                btnColor: selectPayment == ""
                                    ? Colors.grey
                                    : PRIMARY_COLOR,
                              );
                            });
                      }),
                ),
              ),
            );
          }),
    );
  }

  void goToNextPage(BuildContext context, SnackPaymentBloc bloc) {
    List<SnackRequest>? snackRequest;
    if (bloc.selectPayment != "") {
      snackRequest?.add(SnackRequest(1, 1));
      _navigateToPaymentInfoPage(
          context,
          movieName!,
          date,
          time!,
          cinemaName!,
          cinema,
          row,
          seat,
          bloc.grandTotal,
          timeslot,
          snackRequest ?? [SnackRequest(1, 2)]);
    }
  }
}

void _navigateToPaymentInfoPage(
    BuildContext context,
    MovieVO movie,
    String date,
    String time,
    String cinemaName,
    CinemaVO cinema,
    String row,
    String seat,
    double total,
    int timeslot,
    List<SnackRequest> snackRequest) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentInfoPage(
        movie: movie,
        date: date,
        time: time,
        cinemaName: cinemaName,
        cinema: cinema,
        row: row,
        seat: seat,
        totalCost: total,
        timeslot: timeslot,
        snackrequest: snackRequest,
      ),
    ),
  );
}

class PaymentMethodView extends StatelessWidget {
  List<PaymentVO> paymentList;
  Function(int?) selectedPayment;
  PaymentMethodView({required this.paymentList, required this.selectedPayment});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paymentList.map((payment) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: ListTile(
            onTap: () {
              selectedPayment(paymentList.indexOf(payment));
            },
            horizontalTitleGap: 4.0,
            leading: const Icon(
              Icons.credit_card,
            ),
            title: GestureDetector(
              onTap: () {
                selectedPayment(paymentList.indexOf(payment));
              },
              child: Text(
                payment.name ?? "",
                style: TextStyle(
                  color:
                      payment.isSelected == true ? PRIMARY_COLOR : Colors.black,
                ),
              ),
            ),
            subtitle: Text(
              payment.description ?? "",
              style: TextStyle(
                color: payment.isSelected == true ? PRIMARY_COLOR : Colors.grey,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class PromoTextFormView extends StatelessWidget {
  double totalCost;
  PromoTextFormView({required this.totalCost});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter promo code',
              labelStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          RichText(
            text: const TextSpan(
              text: 'Don\'t have any promo code? ',
              style: TextStyle(
                color: Colors.black26,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' Get it now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Subtotal : $totalCost\$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: GREEN_COLOR,
              fontSize: 18.0,
            ),
          )
        ],
      ),
    );
  }
}

class SnackInfoListView extends StatelessWidget {
  final List<SnackVO> snackList;
  Function(int) onAdded;
  Function(int) onRemoved;
  SnackInfoListView(
      {required this.snackList,
      required this.onAdded,
      required this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: snackList
          .map(
            (item) => SnackInfoView(
              item: item,
              onAdded: () => onAdded(snackList.indexOf(item)),
              onRemoved: () => onRemoved(snackList.indexOf(item)),
            ),
          )
          .toList(),
    );
  }
}

class SnackInfoView extends StatelessWidget {
  final SnackVO item;
  Function onAdded;
  Function onRemoved;
  SnackInfoView(
      {required this.item, required this.onAdded, required this.onRemoved});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 10.0,
      title: Text(item.name ?? ""),
      subtitle: SubtitleText(item.description ?? ""),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${item.price}\$",
          ),
          const SizedBox(
            height: 3.0,
          ),
          Container(
            width: 100.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5.0,
              ),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    onRemoved();
                  },
                  child: Icon(
                    Icons.remove,
                    key: ValueKey(item.name ?? ""),
                  ),
                ),
                const VerticalDivider(
                  thickness: 1.0,
                  color: Colors.black26,
                ),
                Text(
                  item.quantity.toString(),
                ),
                const VerticalDivider(
                  thickness: 1.0,
                  color: Colors.black26,
                ),
                GestureDetector(
                  onTap: () {
                    onAdded();
                  },
                  child: Icon(
                    Icons.add,
                    key: ValueKey(item.id ?? 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  const SubtitleText(
    this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
