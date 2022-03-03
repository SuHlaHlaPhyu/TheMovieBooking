import 'dart:ffi';

import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/network/checkout_request.dart';

abstract class AuthModel {
  /// from network
  // Future<List> loginWithEmail(
  //   String email,
  //   String password,
  // );
  // Future<List> registerWithEmail(
  //   String name,
  //   String email,
  //   String phone,
  //   String password,
  //   String googleToken,
  //   String facebookToken,
  // );
  Future<List> logout(
    String token,
  );
  // Future<List> loginWithGoogle(
  //   String accessToken,
  // );
  // Future<List> loginWithFacebook(
  //   String accessToken,
  // );
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(
    String token,
    String date,
  );
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
    String token,
    int cinemaDaytimeslotId,
    String bookingDate,
  );
  Future<List<SnackVO>?> getSnackList(
    String token,
  );
  Future<List<UserCardVO>?> createCard(
    String token,
    int cardNumber,
    String cardHolder,
    String expirationDate,
    int cvc,
  );
  Future<UserDataVO?> getProfile(
    String token,
  );
  Future<List<PaymentVO>?> getPaymentMethodList(
    String token,
  );

  Future<CheckoutVO?> checkout(String token, CheckOutRequest request);

  /// from database
  Stream<UserDataVO?> getUserDatafromDatabase();
  Future<String> getUserTokenfromDatabase();
  Future<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date);
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase();
  Future<List<SnackVO>?> getSnackListFromDatabase();
  Future<List<PaymentVO>?> getPaymentMethodListFromDatabase();
  Future<List<UserCardVO>?> getUserCardsFromDatabase();

  /// stream
  void loginWithEmail(
    String email,
    String password,
  );

  void registerWithEmail(
    String name,
    String email,
    String phone,
    String password,
    String googleToken,
    String facebookToken,
  );

  void loginWithGoogle(
    String accessToken,
  );
  void loginWithFacebook(
    String accessToken,
  );
}
