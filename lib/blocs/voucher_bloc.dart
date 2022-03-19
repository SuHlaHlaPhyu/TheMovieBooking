import 'package:flutter/foundation.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';

import '../data/vos/checkout_vo.dart';
import '../data/vos/movie_vo.dart';

class VoucherBloc extends ChangeNotifier {
  /// states
  MovieVO? movieVO;
  CheckoutVO? checkoutVO;

  /// model
  AuthModel authModel = AuthModelImpl();

  VoucherBloc(MovieVO movie, CheckoutVO checkout) {
    movieVO = movie;
    checkoutVO = checkout;
    notifyListeners();
  }
}
