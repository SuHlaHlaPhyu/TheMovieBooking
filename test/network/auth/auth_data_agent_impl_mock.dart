import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/network/auth/auth_data_agent.dart';
import 'package:movie_booking/network/checkout_request.dart';

import '../../mock_data/auth_mock_data.dart';

class AuthDataAgentImplMock extends AuthDataAgent{
  @override
  Future<CheckoutVO?> checkOut(String token, CheckOutRequest request) {
    // TODO: implement checkOut
    throw UnimplementedError();
  }

  @override
  Future<List<UserCardVO>?> createCard(String token, int cardNumber, String cardHolder, String expirationDate, int cvc) {
    // TODO: implement createCard
    throw UnimplementedError();
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(String token, String date) {
    return Future.value(getMockCinemaTimeslot().cinemaList);
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(String token, int cinemaDaytimeslotId, String bookingDate) {
    // TODO: implement getCinemaSeatingPlan
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethodList(String token) {
    // TODO: implement getPaymentMethodList
    throw UnimplementedError();
  }

  @override
  Future<UserDataVO?> getProfile(String token) {
    return Future.value(getUserDataMockTest());
  }

  @override
  Future<List<SnackVO>?> getSnackList(String token) {
    // TODO: implement getSnackList
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
  Future<List> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone, String password, String googleToken, String facebookToken) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }
  
}