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
   getMockCinemaTimeslot();
  }

  @override
  Stream<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date) {
    return Stream.value(getMockCinemaTimeslot().cinemaList);
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(int cinemaDaytimeslotId, String bookingDate) {
    return Future.value([getMockSeatPlan()]);
  }

  @override
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase() {
    return Future.value(getMockSeatPlan());
  }

  @override
  void getPaymentMethodList() {
    getMockPaymentMethods();
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodListFromDatabase() {
    return Stream.value(getMockPaymentMethods());
  }

  @override
  void getProfile() {
    //getUserDataMockTest();
  }

  @override
  void getSnackList() {
    // TODO: implement getSnackList
  }

  @override
  Stream<List<SnackVO>?> getSnackListFromDatabase() {
    return Stream.value(getMockSnack());
  }

  @override
  Stream<List<UserCardVO>?> getUserCardsFromDatabase() {
    return Stream.value(getMockUserCard());
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
    return Future.value([getUserDataMockTest()]);
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    return Future.value([getUserDataMockTest()]);
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    return Future.value([getUserDataMockTest()]);
  }

  @override
  Future<List> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone, String password, String googleToken, String facebookToken) {
    return Future.value([getUserDataMockTest()]);
  }
  
}