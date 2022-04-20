import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/network/checkout_request.dart';

import '../../../mock_data/auth_mock_data.dart';

class AuthModelImplMock extends AuthModel{
  @override
  Future<CheckoutVO?> checkout(CheckOutRequest request) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<List<UserCardVO>?> createCard(int cardNumber, String cardHolder, String expirationDate, int cvc) {
    // TODO: implement createCard
    throw UnimplementedError();
  }

  @override
  void getCinemaDayTimeSlot(String date) {
    // TODO: implement getCinemaDayTimeSlot
  }

  @override
  Stream<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date) {
    // TODO: implement getCinemaDayTimeSlotFromDataBase
    throw UnimplementedError();
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(int cinemaDaytimeslotId, String bookingDate) {
    // TODO: implement getCinemaSeatingPlan
    throw UnimplementedError();
  }

  @override
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase() {
    // TODO: implement getCinemaSeatingPlanFromDatabase
    throw UnimplementedError();
  }

  @override
  void getPaymentMethodList() {
    // TODO: implement getPaymentMethodList
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodListFromDatabase() {
    // TODO: implement getPaymentMethodListFromDatabase
    throw UnimplementedError();
  }

  @override
  void getProfile() {
    getUserDataMockTest();
  }

  @override
  void getSnackList() {
    // TODO: implement getSnackList
  }

  @override
  Stream<List<SnackVO>?> getSnackListFromDatabase() {
    // TODO: implement getSnackListFromDatabase
    throw UnimplementedError();
  }

  @override
  Stream<List<UserCardVO>?> getUserCardsFromDatabase() {
    // TODO: implement getUserCardsFromDatabase
    throw UnimplementedError();
  }

  @override
  Stream<UserDataVO?> getUserDatafromDatabase() {
    return Stream.value(getUserDataMockTest());
  }

  @override
  Future<String> getUserTokenfromDatabase() {
    // TODO: implement getUserTokenfromDatabase
    throw UnimplementedError();
  }

  @override
  Future<List> loginWithEmail(String email, String password) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<List> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone, String password, String googleToken, String facebookToken) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }
  
}