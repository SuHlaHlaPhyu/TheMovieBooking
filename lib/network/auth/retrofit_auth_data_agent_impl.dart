import 'package:dio/dio.dart';
import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/network/checkout_request.dart';

import 'auth_api.dart';
import 'auth_data_agent.dart';

class RetrofitAuthDataAgentImpl extends AuthDataAgent {
  late AuthApi mapi;

  static final RetrofitAuthDataAgentImpl _singleton =
      RetrofitAuthDataAgentImpl._internal();

  factory RetrofitAuthDataAgentImpl() {
    return _singleton;
  }

  RetrofitAuthDataAgentImpl._internal() {
    final dio = Dio();
    mapi = AuthApi(dio);
  }
  @override
  Future<List> loginWithEmail(String email, String password) {
    return mapi
        .loginWithEmail(email, password)
        .asStream()
        .map((response) => [
              response.code,
              response.message,
              response.data,
              response.token,
            ])
        .first;
  }

  // @override
  // Future<List> loginWithEmail(String email, String password) {
  //   return mapi
  //       .loginWithEmail(email, password)
  //       .then((value) {
  //         if (value.code == 200) {
  //           return Future<List>.value(
  //               [value.code, value.message, value.data, value.token]);
  //         } else {
  //           return Future<List>.error([value.message]);
  //         }
  //       })
  //       .asStream()
  //       .map((event) => event)
  //       .first;
  // }

  @override
  Future<List> registerWithEmail(String name, String email, String phone,
      String password, String googleToken, String facebookToken) {
    return mapi
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .asStream()
        .map((response) => [
              response.code,
              response.message,
              response.data,
              response.token,
            ])
        .first;
  }

  @override
  Future<List> logout(String token) {
    return mapi.logout(token).then((value) {
      return [value.code, value.message];
    });
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(String token, String date) {
    return mapi
        .getCinemaDayTimeSlot(token, date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
      String token, int cinemaDaytimeslotId, String bookingDate) {
    return mapi
        .getCinemaSeatingPlan(token, cinemaDaytimeslotId, bookingDate)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<SnackVO>?> getSnackList(String token) {
    return mapi
        .getSnackList(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<UserCardVO>?> createCard(String token, int cardNumber,
      String cardHolder, String expirationDate, int cvc) {
    return mapi
        .creatCard(token, cardNumber, cardHolder, expirationDate, cvc)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethodList(String token) {
    return mapi
        .getPaymentMethodList(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<UserDataVO?> getProfile(String token) {
    return mapi
        .profile(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<CheckoutVO?> checkOut(String token, CheckOutRequest request) {
    return mapi
        .checkOut(token, request)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    return mapi
        .loginWithFacebook(accessToken)
        .asStream()
        .map((response) => [
              response.code,
              response.message,
              response.data,
              response.token,
            ])
        .first;
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    return mapi
        .loginWithGoogle(accessToken)
        .asStream()
        .map((response) => [
              response.code,
              response.message,
              response.data,
              response.token,
            ])
        .first;
  }
}
