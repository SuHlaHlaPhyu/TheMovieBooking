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
import 'package:movie_booking/persistance/daos/impl/card_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/cinema_day_timeslot_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/payment_method_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/seat_plan_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/snack_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/user_data_dao_impl.dart';
import 'package:movie_booking/persistance/daos/payment_method_dao.dart';
import 'package:movie_booking/persistance/daos/seat_plan_dao.dart';
import 'package:movie_booking/persistance/daos/snack_dao.dart';
import 'package:movie_booking/persistance/daos/user_data_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../vos/cinema_list_for_hive_vo.dart';
import 'auth_model.dart';

class AuthModelImpl extends AuthModel {
  AuthDataAgent dataAgent = RetrofitAuthDataAgentImpl();

  static final AuthModelImpl _singleton = AuthModelImpl._internal();
  factory AuthModelImpl() {
    return _singleton;
  }

  AuthModelImpl._internal();

  /// Daos
  UserDataDao userDataDao = UserDataDaoImpl();
  CinemaDayTimeslotDao timeSlotDao = CinemaDayTimeslotDaoImpl();
  SeatPlanDao seatPlanDao = SeatPlanDaoImpl();
  SnackDao snackDao = SnackDaoImpl();
  PaymentMethodDao paymentMethodDao = PaymentMethodDaoImpl();
  UserCardDao userCardDao = UserCardDaoImpl();

  /// for testing purpose
  void setDaosAndDataAgents(
      UserDataDao userDataDaoTest,
       CinemaDayTimeslotDao timeSlotDaoTest,
       SeatPlanDao seatPlanDaoTest,
      SnackDao snackDaoTest,
      // PaymentMethodDao paymentMethodDaoTest,
      // UserCardDao userCardDaoTest,
      AuthDataAgent authDataAgentTest
      ) {
    // userCardDao = userCardDaoTest;
     timeSlotDao = timeSlotDaoTest;
     seatPlanDao = seatPlanDaoTest;
     snackDao = snackDaoTest;
    // paymentMethodDao = paymentMethodDaoTest;
    userDataDao = userDataDaoTest;
    dataAgent = authDataAgentTest;
  }

  /// from network
  @override
  Future<List> logout() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return dataAgent.logout(token).then((value) {
      userDataDao.clearUserData();
      return Future.value(value);
    });
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
      int cinemaDaytimeslotId, String bookingDate) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return dataAgent
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
    return dataAgent.createCard(
        token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<CheckoutVO?> checkout(CheckOutRequest request) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    return dataAgent.checkOut(token, request);
  }

  /// from database

  @override
  Future<String> getUserTokenfromDatabase() {
    return Future.value(userDataDao.getUserToken());
  }

  // @override
  // Future<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date) {
  //   return Future.value(timeSlotDao.getAllCinemaDayTimeslot(date)?.cinemaList);
  // }

  @override
  Future<List<SeatingPlanVO>?> getCinemaSeatingPlanFromDatabase() {
    return Future.value(seatPlanDao.getAllSeatPlan());
  }

  /// reactive
  @override
  Future<List> loginWithEmail(String email, String password) {
    return dataAgent.loginWithEmail(email, password).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone,
      String password, String googleToken, String facebookToken) {
    return dataAgent
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    return dataAgent.loginWithFacebook(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    return dataAgent.loginWithGoogle(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  void getSnackList() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    dataAgent.getSnackList(token).then((value) {
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
    dataAgent.getPaymentMethodList(token).then((value) {
      paymentMethodDao.saveAllPaymentMethod(value!);
    });
  }

  @override
  void getProfile() {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    dataAgent.getProfile(token).then((value) {
      userCardDao.saveAllUserCards(value!.cards!);
    });
  }

  @override
  void getCinemaDayTimeSlot(String date) {
    String token = "Bearer " + userDataDao.getUserToken().toString();
    dataAgent.getCinemaDayTimeSlot(token, date).then((value) {
      List<CinemaVO> timeSlotList = value!.map((timeSlot) {
        timeSlot.timeslots?.map((time) {
          time.isSelected = false;
          return time;
        }).toList();
        return timeSlot;
      }).toList();
      CinemaListForHiveVO cinemaList = CinemaListForHiveVO(timeSlotList);
      timeSlotDao.saveAllCinemaDayTimeslot(date, cinemaList);
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
    getPaymentMethodList();
    return paymentMethodDao
        .getPaymentMethodEventStream()
        // ignore: void_checks
        .startWith(paymentMethodDao.getAllPaymentMethodStream())
        .map((event) => paymentMethodDao.getAllPaymentMethod());
  }

  @override
  Stream<List<UserCardVO>?> getUserCardsFromDatabase() {
    getProfile();
    return userCardDao
        .getUserCardEventStream()
        // ignore: void_checks
        .startWith(userCardDao.getAllUserCardsStream())
        .map((event) => userCardDao.getAllUserCards());
  }

  @override
  Stream<List<CinemaVO>?> getCinemaDayTimeSlotFromDataBase(String date) {
    getCinemaDayTimeSlot(date);
    return timeSlotDao
        .getCinemaEventStream()
        // ignore: void_checks
        .startWith(timeSlotDao.getAllCinemaDayTimeslotStream(date))
        .map((event) => timeSlotDao.getAllCinemaDayTimeslot(date)?.cinemaList);
  }
}
