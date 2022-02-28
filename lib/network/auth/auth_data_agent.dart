import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/network/checkout_request.dart';

abstract class AuthDataAgent {
  Future<List> loginWithEmail(
    String email,
    String password,
  );
  Future<List> registerWithEmail(
    String name,
    String email,
    String phone,
    String password,
    String googleToken,
    String facebookToken,
  );
  Future<List> logout(
    String token,
  );
  Future<List> loginWithGoogle(
    String accessToken,
  );
  Future<List> loginWithFacebook(
    String accessToken,
  );
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
  Future<CheckoutVO?> checkOut(String token, CheckOutRequest request);
}
