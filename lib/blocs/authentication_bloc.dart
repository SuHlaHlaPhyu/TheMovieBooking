import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/user_data_vo.dart';

class AuthenticationBloc extends ChangeNotifier {
  /// state
  String? message;
  UserDataVO? userData;
  String? token;
  int? code;
  String googleToken = "";
  String facebookToken = "";
  Map _userObj = {};
  String? name, email;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  /// model
  AuthModel authModel = AuthModelImpl();

  /// email login
  Future<List> onTapEmailLogin(String email, String password) {
    return authModel.loginWithEmail(email, password).then((value) {
      notifyListeners();
      return Future.value(value);
    });
  }

  /// google login
  Future<List> googleLogin() {
    return _googleSignIn.signIn().then((googleAccount) {
      return Future.value(googleAccount?.authentication.then((authentication) {
        notifyListeners();
        return loginWithGoogle(authentication.accessToken);
      }));
    });
  }

  /// api
  Future<List> loginWithGoogle(String? token) {
    return authModel.loginWithGoogle(token ?? "").then((value) {
      return Future.value(value);
    });
  }

  /// facebook login
  Future<List> facebookLogin() {
    return FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      notifyListeners();
      return loginWithFacebook(value.accessToken?.userId);
    });
  }

  /// api
  Future<List> loginWithFacebook(String? token) {
    return authModel.loginWithFacebook(token ?? "").then((value) {
      return Future.value(value);
    });
  }

  /// register account
  Future<List> registerWithEmail(String name, String phone, String email,
      String password, String googlToken, String facebookToken) {
    return authModel
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .then((value) {
      notifyListeners();
      return Future.value(value);
    });
  }

  /// google sign in
  void googleSignIn() {
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        name = googleAccount.displayName;
        email = googleAccount.email;
        googleToken = authentication.accessToken ?? "";
        notifyListeners();
      });
    });
  }

  /// facebook sign in
  void facebookSignIn() {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        _userObj = userData;
        name = _userObj["name"];
        email = _userObj["email"];
        facebookToken = value.accessToken?.userId ?? "";
        notifyListeners();
      });
    });
  }
}
