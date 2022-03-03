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
  Future<List> logout();
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(
    String date,
  );
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
    int cinemaDaytimeslotId,
    String bookingDate,
  );
  Future<List<UserCardVO>?> createCard(
    int cardNumber,
    String cardHolder,
    String expirationDate,
    int cvc,
  );

  Future<CheckoutVO?> checkout(CheckOutRequest request);

  /// from database
  Stream<UserDataVO?> getUserDatafromDatabase();
  Future<String> getUserTokenfromDatabase();
  Future<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date);
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase();
  Stream<List<SnackVO>?> getSnackListFromDatabase();
  Stream<List<PaymentVO>?> getPaymentMethodListFromDatabase();
  Stream<List<UserCardVO>?> getUserCardsFromDatabase();

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

  void getSnackList();

  void getPaymentMethodList();
  void getProfile();
}
