import 'package:flutter/material.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/network/snack_request.dart';
import 'package:movie_booking/pages/payment_info_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/widgets/app_text_button.dart';

class SnackInfoPage extends StatefulWidget {
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
  _SnackInfoPageState createState() => _SnackInfoPageState();
}

class _SnackInfoPageState extends State<SnackInfoPage> {
  AuthModel authModel = AuthModelImpl();
  String selectPayment = "";
  List<SnackVO> snackList = [];
  List<PaymentVO>? paymentList;
  double grandTotal = 0;
  List<SnackRequest>? snackRequest;
  @override
  void initState() {
    // // snack list
    grandTotal += widget.totalCost;
    authModel.getUserTokenfromDatabase().then((value) {
      // authModel.getSnackList("Bearer " + value).then((snack) {
      //   setState(() {
      //     snackList = snack!;
      //   });
      // }).catchError((error) {
      //   debugPrint(error.toString());
      // });

      // snack list from db
      authModel.getSnackListFromDatabase().then((snack) {
        setState(() {
          snackList = snack!;
          print("snack list from db $snackList");
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });

      /// payment methods
      authModel.getPaymentMethodList("Bearer " + value).then((payment) {
        setState(() {
          paymentList = payment;
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });

    /// payment methods
    authModel.getPaymentMethodListFromDatabase().then((payment) {
      setState(() {
        paymentList = payment;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SnackInfoListView(
              snackList: snackList,
              onAdded: (index) {
                // add quatity
                setState(() {
                  int q = snackList[index].quantity!;
                  q++;
                  snackList[index].quantity = q;
                  grandTotal += snackList[index].price!;
                });
              },
              onRemoved: (index) {
                // remove quantity
                setState(() {
                  int q = snackList[index].quantity!;
                  if (q != 0) {
                    q--;
                    grandTotal -= snackList[index].price!;
                    snackList[index].quantity = q;
                  }
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            PromoTextFormView(
              totalCost: grandTotal,
            ),
            const SizedBox(
              height: 20.0,
            ),
            PaymentMethodView(
              paymentList: paymentList ?? [],
              selectedPayment: (selectIndex) {
                setState(() {
                  selectPayment = paymentList![selectIndex!].name!;
                  paymentList
                      ?.map((payment) => payment.isSelected = false)
                      .toList();
                  paymentList?[selectIndex].isSelected = true;
                  //
                });
              },
            ),
            const SizedBox(
              height: 200.0,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
        ),
        child: GestureDetector(
          onTap: () {
            if (selectPayment != "") {
              print("tapped");
              // snackList.map((snack) {
              //   if (snack.quantity != 0) {
              //     print(
              //         "snack id ${snack.id} snack quantity ${snack.quantity}");
              //     snackRequest
              //         ?.add(SnackRequest(snack.id ?? 1, snack.quantity ?? 1));
              //   }
              // });
              snackRequest?.add(SnackRequest(1, 1));
              // print(
              //   "moviename ${widget.movieName!} \n date ${widget.date} \ntime ${widget.time!} \n cinemaName ${widget.cinemaName!} \n cinema ${widget.cinema} \n row ${widget.row} \n seat ${widget.seat} grandtotal $grandTotal \n timeslot ${widget.timeslot} \n snack $snackRequest",
              // );
              _navigateToPaymentInfoPage(
                  context,
                  widget.movieName!,
                  widget.date,
                  widget.time!,
                  widget.cinemaName!,
                  widget.cinema,
                  widget.row,
                  widget.seat,
                  grandTotal,
                  widget.timeslot,
                  snackRequest ?? [SnackRequest(1, 2)]);
            }
          },
          child: AppTextButton("Pay \$ $grandTotal",
              btnColor: selectPayment == "" ? Colors.grey : PRIMARY_COLOR),
        ),
      ),
    );
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
            title: Text(
              payment.name ?? "",
              style: TextStyle(
                color:
                    payment.isSelected == true ? PRIMARY_COLOR : Colors.black,
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
// const ListTile(
//   horizontalTitleGap: 4.0,
//   leading: Icon(
//     Icons.credit_card,
//   ),
//   title: Text(
//     'Credit card',
//   ),
//   subtitle: SubtitleText(
//     'Visa, master card, JCB',
//   ),
// ),

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
                  child: const Icon(
                    Icons.remove,
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
                  child: const Icon(
                    Icons.add,
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
