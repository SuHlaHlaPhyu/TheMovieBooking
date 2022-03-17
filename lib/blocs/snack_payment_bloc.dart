import 'package:flutter/foundation.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/payment_vo.dart';
import '../data/vos/snack_vo.dart';
import '../network/snack_request.dart';

class SnackPaymentBloc extends ChangeNotifier {
  /// state
  String selectPayment = "";
  List<SnackVO> snackList = [];
  List<PaymentVO>? paymentList;
  double grandTotal = 0;
  List<SnackRequest>? snackRequest;

  /// model
  AuthModel authModel = AuthModelImpl();

  SnackPaymentBloc() {
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
  void subtractQuantity(int index) {
    int q = snackList[index].quantity!;
    if (q != 0) {
      q--;
      grandTotal -= snackList[index].price!;
      snackList[index].quantity = q;
    }
    notifyListeners();
  }

  void addQuantity(int index) {
    int q = snackList[index].quantity!;
    q++;
    snackList[index].quantity = q;
    grandTotal += snackList[index].price!;
    notifyListeners();
  }

  void selectedPaymentMethods(int? selectIndex) {
    selectPayment = paymentList![selectIndex!].name!;
    paymentList?.map((payment) {
      payment.isSelected = false;
      notifyListeners();
    }).toList();
    paymentList?[selectIndex].isSelected = true;
    notifyListeners();
  }
}
