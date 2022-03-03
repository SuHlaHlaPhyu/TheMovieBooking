import 'package:movie_booking/data/vos/checkout_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/network/auth/auth_data_agent.dart';
import 'package:movie_booking/network/auth/retrofit_auth_data_agent_impl.dart';
import 'package:movie_booking/network/checkout_request.dart';
import 'package:movie_booking/persistance/daos/card_dao.dart';
import 'package:movie_booking/persistance/daos/cinema_day_timeslot_dao.dart';
import 'package:movie_booking/persistance/daos/payment_method_dao.dart';
import 'package:movie_booking/persistance/daos/seat_plan_dao.dart';
import 'package:movie_booking/persistance/daos/snack_dao.dart';
import 'package:movie_booking/persistance/daos/user_data_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../vos/cinema_list_for_hive_vo.dart';
import 'auth_model.dart';

class AuthModelImpl extends AuthModel {
  final AuthDataAgent _dataAgent = RetrofitAuthDataAgentImpl();

  static final AuthModelImpl _singleton = AuthModelImpl._internal();
  factory AuthModelImpl() {
    return _singleton;
  }

  AuthModelImpl._internal();

  UserDataDao userDataDao = UserDataDao();
  CinemaDayTimeslotDao timeSlotDao = CinemaDayTimeslotDao();
  SeatPlanDao seatPlanDao = SeatPlanDao();
  SnackDao snackDao = SnackDao();
  PaymentMethodDao paymentMethodDao = PaymentMethodDao();
  UserCardDao userCardDao = UserCardDao();

  /// from network

  // @override
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(String date) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return _dataAgent.getCinemaDayTimeSlot(token, date).then((value) {
      List<CinemaVO> timeSlotList = value!.map((timeSlot) {
        timeSlot.timeslots?.map((time) {
          time.isSelected = false;
          return time;
        }).toList();
        return timeSlot;
      }).toList();
      CinemaListForHiveVO cinemaList = CinemaListForHiveVO(timeSlotList);
      timeSlotDao.saveAllCinemaDayTimeslot(date, cinemaList);
      return Future.value(value);
    });
  }

  @override
  Future<List> logout() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return _dataAgent.logout(token).then((value) {
      userDataDao.clearUserData();
      return Future.value(value);
    });
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
      int cinemaDaytimeslotId, String bookingDate) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return _dataAgent
        .getCinemaSeatingPlan(token, cinemaDaytimeslotId, bookingDate)
        .then((value) {
      List<SeatingPlanVO> seatPlanList =
          value!.expand((element) => element).toList().map((seat) {
        seat.isSelected = false;
        return seat;
      }).toList();
      seatPlanDao.saveAllSeatPlan(seatPlanList);
      return Future.value(value);
    });
  }

  @override
  Future<List<UserCardVO>?> createCard(
      int cardNumber, String cardHolder, String expirationDate, int cvc) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return _dataAgent.createCard(
        token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<CheckoutVO?> checkout(CheckOutRequest request) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return _dataAgent.checkOut(token, request);
  }

  /// from database

  @override
  Future<String> getUserTokenfromDatabase() {
    return Future.value(userDataDao.getUserToken());
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date) {
    return Future.value(timeSlotDao.getAllCinemaDayTimeslot(date)?.cinemaList);
  }

  @override
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase() {
    return Future.value(seatPlanDao.getAllSeatPlan());
  }

  /// reactive
  @override
  void loginWithEmail(String email, String password) {
    _dataAgent.loginWithEmail(email, password).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
    });
  }

  @override
  void registerWithEmail(String name, String email, String phone,
      String password, String googleToken, String facebookToken) {
    _dataAgent
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
    });
  }

  @override
  void loginWithFacebook(String accessToken) {
    _dataAgent.loginWithFacebook(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
    });
  }

  @override
  void loginWithGoogle(String accessToken) {
    _dataAgent.loginWithGoogle(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
    });
  }

  @override
  void getSnackList() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    _dataAgent.getSnackList(token).then((value) {
      List<SnackVO> snackList = value!.map((snack) {
        snack.quantity = 0;
        return snack;
      }).toList();
      snackDao.saveAllSnackInfo(snackList);
    });
  }

  @override
  void getPaymentMethodList() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    _dataAgent.getPaymentMethodList(token).then((value) {
      paymentMethodDao.saveAllPaymentMethod(value!);
    });
  }

  @override
  void getProfile() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    _dataAgent.getProfile(token).then((value) {
      userCardDao.saveAllUserCards(value!.cards!);
    });
  }

  /// from database
  @override
  Stream<UserDataVO?> getUserDatafromDatabase() {
    return userDataDao
        .getUserDataEventStream()
        // ignore: void_checks
        .startWith(userDataDao.getUserDataStream())
        .map((event) => userDataDao.getUserData());
  }

  @override
  Stream<List<SnackVO>?> getSnackListFromDatabase() {
    getSnackList();
    return snackDao
        .getSnackListEventStream()
        // ignore: void_checks
        .startWith(snackDao.getAllSnackInfoStream())
        .map((event) => snackDao.getAllSnackInfo());
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodListFromDatabase() {
    return paymentMethodDao
        .getPaymentMethodEventStream()
        .startWith(paymentMethodDao.getAllPaymentMethodStream())
        .map((event) => paymentMethodDao.getAllPaymentMethod());
  }

  @override
  Stream<List<UserCardVO>?> getUserCardsFromDatabase() {
    return userCardDao
        .getUserCardEventStream()
        .startWith(userCardDao.getAllUserCardsStream())
        .map((event) => userCardDao.getAllUserCards());
  }
}
