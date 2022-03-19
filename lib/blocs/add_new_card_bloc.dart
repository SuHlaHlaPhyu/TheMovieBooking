import 'package:flutter/foundation.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';

import '../data/vos/user_card_vo.dart';

class AddNewCardBloc extends ChangeNotifier {
  /// states

  /// models
  AuthModel authModel = AuthModelImpl();

  Future<List<UserCardVO>?> addNewCard(
      int cardNumber, String cardHolder, String expirationDate, int cvc) {
    return authModel
        .createCard(cardNumber, cardHolder, expirationDate, cvc)
        .then((value) {
      authModel.getProfile();
      notifyListeners();
      return Future.value(value);
    });
  }
}
