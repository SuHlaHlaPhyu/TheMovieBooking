import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/payment_vo.dart';
import '../data/vos/snack_vo.dart';
import 'package:collection/collection.dart';

class SnackPaymentBloc extends ChangeNotifier {
  /// state
  String selectPayment = "";
  List<SnackVO> snackList = [];
  List<PaymentVO>? paymentList;
  double grandTotal = 0;

  /// model
  AuthModel authModel = AuthModelImpl();

  SnackPaymentBloc([AuthModel? authModelTest]) {
    ///
    if(authModelTest != null){
      authModel = authModelTest;
    }
    // snack list
    authModel.getSnackListFromDatabase().listen((snack) {
      snackList = snack!;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// payment methods
    authModel.getPaymentMethodListFromDatabase().listen((payment) {
      paymentList = payment;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void addQuantity(SnackVO item) {
    var newList = snackList.map((element) {
      if (element == item) {
        int q = element.quantity ?? 0;
        q++;
        element.quantity = q;
        grandTotal += element.price ?? 0;
      }
      return element;
    }).toList();
    snackList = newList;
    notifyListeners();
  }

  void subtractQuantity(SnackVO item) {
    var newList = snackList.map((element) {
      if (element == item) {
        int q = element.quantity!;
        if (q != 0) {
          q--;
          element.quantity = q;
          grandTotal -= element.price!;
        }
      }
      return element;
    }).toList();
    snackList = newList;
    notifyListeners();
  }

  void selectedPaymentMethods(int? selectIndex) {
    selectPayment = paymentList![selectIndex!].name!;
    List<PaymentVO> newList = paymentList!.map((payment) {
      payment.isSelected = false;
      return payment;
    }).mapIndexed((index, element) {
      paymentList?[selectIndex].isSelected = true;
      return element;
    }).toList();
    paymentList = newList;
    notifyListeners();
  }
}

