import 'package:flutter/foundation.dart';
import 'package:movie_booking/configs/config_values.dart';
import 'package:movie_booking/configs/environment_config.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/checkout_vo.dart';
import '../data/vos/user_card_vo.dart';
import '../network/checkout_request.dart';

class CardBloc extends ChangeNotifier {
  /// state
  List<UserCardVO>? cardList;
  CheckoutVO? checkoutVO;
  MovieVO? movieVO;

  /// model
  AuthModel authModel = AuthModelImpl();

  CardBloc([AuthModel? authModelTest]) {
    /// mock
    if(authModelTest != null){
      authModel = authModelTest;
    }
    authModel.getUserCardsFromDatabase().listen((card) {
      cardList = card?.reversed.toList();
      if(USER_CARD[EnvironmentConfig.CONFIG_USER_CARD] == "Horizontal list"){
        cardList?[0].isSelected = true;
      } else {
        cardList?[0].isSelected = false;
      }
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  Future<CheckoutVO> sendCheckoutRequest(
      CheckOutRequest request, MovieVO movie) {
    return authModel.checkout(request).then((value) {
      movieVO = movie;
      checkoutVO = value;
      notifyListeners();
      return Future.value(checkoutVO);
    });
  }
}
