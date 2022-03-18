import 'package:flutter/foundation.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/checkout_vo.dart';
import '../data/vos/user_card_vo.dart';
import '../network/checkout_request.dart';

class CardBloc extends ChangeNotifier {
  /// state
  List<UserCardVO>? cardList;
  CheckOutRequest? checkOutRequest;
  int cardId = 0;
  late CheckoutVO checkoutVO;

  /// model
  AuthModel authModel = AuthModelImpl();

  CardBloc() {
    authModel.getUserCardsFromDatabase().listen((card) {
      cardList = card;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  Future<CheckoutVO> sendCheckoutRequest(CheckOutRequest request) {
    return authModel.checkout(request).then((value) {
      checkoutVO = value!;
      return Future.value(value);
    });
  }
}
