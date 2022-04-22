import 'package:flutter/foundation.dart';
import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/user_data_vo.dart';

class WelcomeBloc extends ChangeNotifier {
  /// state
  UserDataVO? userData;

  AuthModel authModel = AuthModelImpl();

  WelcomeBloc([AuthModel? authModelTest]) {
    /// mock
    if(authModelTest != null){
      authModel = authModelTest;
    }
    authModel.getUserDatafromDatabase().listen((user) {
      userData = user;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }
}
