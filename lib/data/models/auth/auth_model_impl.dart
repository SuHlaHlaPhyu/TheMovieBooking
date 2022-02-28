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

  @override
  Future<List> loginWithEmail(String email, String password) {
    return _dataAgent.loginWithEmail(email, password).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone,
      String password, String googleToken, String facebookToken) {
    return _dataAgent
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  // @override
  // Future<List<CinemaVO>?> getCinemaDayTimeSlot(String token, String date) {
  //   return _dataAgent.getCinemaDayTimeSlot(token, date).then((value) {
  //     List<CinemaVO> timeSlotList = value!.map((timeSlot) {
  //       timeSlot.isSelected = true;
  //       return timeSlot;
  //     }).toList();
  //     timeSlotDao.saveAllCinemaDayTimeslot(timeSlotList);
  //     return Future.value(value);
  //   });
  // }
  // @override
  // Future<List<CinemaVO>?> getCinemaDayTimeSlot(String token, String date) {
  //   return _dataAgent.getCinemaDayTimeSlot(token, date).then((value) {
  //     List<CinemaVO> timeSlotList = value!.map((timeSlot) {
  //       timeSlot.timeslots?.map((time) {
  //         time.isSelected = false;
  //         return time;
  //       }).toList();
  //       return timeSlot;
  //     }).toList();
  //     timeSlotDao.saveAllCinemaDayTimeslot(timeSlotList);
  //     return Future.value(value);
  //   });
  // }
  @override
  Future<List<CinemaVO>?> getCinemaDayTimeSlot(String token, String date) {
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
  Future<List> logout(String token) {
    return _dataAgent.logout(token).then((value) {
      userDataDao.clearUserData();
      return Future.value(value);
    });
  }

  @override
  Future<List<List<SeatingPlanVO>>?> getCinemaSeatingPlan(
      String token, int cinemaDaytimeslotId, String bookingDate) {
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

  // @override
  // Future<List<SnackVO>?> getSnackList(String token) {
  //   return _dataAgent.getSnackList(token).then((value) {
  // snackDao.saveAllSnackInfo(value!);
  // return Future.value(value);
  //   });
  // }
  @override
  Future<List<SnackVO>?> getSnackList(String token) {
    return _dataAgent.getSnackList(token).then((value) {
      List<SnackVO> snackList = value!.map((snack) {
        snack.quantity = 0;
        return snack;
      }).toList();
      snackDao.saveAllSnackInfo(snackList);
      return Future.value(value);
    });
  }

  @override
  Future<List<UserCardVO>?> createCard(String token, int cardNumber,
      String cardHolder, String expirationDate, int cvc) {
    return _dataAgent.createCard(
        token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethodList(String token) {
    return _dataAgent.getPaymentMethodList(token).then((value) {
      paymentMethodDao.saveAllPaymentMethod(value!);
      return Future.value(value);
    });
  }

  // @override
  // Future<UserDataVO?> getProfile(String token) {
  //   return _dataAgent.getProfile(token).then((value) {
  //     userDataDao.saveUserData(value!);
  //     return Future.value(value);
  //   });
  // }

  @override
  Future<UserDataVO?> getProfile(String token) {
    return _dataAgent.getProfile(token).then((value) {
      userCardDao.saveAllUserCards(value!.cards!);
      return Future.value(value);
    });
  }

  @override
  Future<UserDataVO> getUserDatafromDatabase() {
    return Future.value(userDataDao.getUserData());
  }

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

  @override
  Future<List<PaymentVO>?> getPaymentMethodListFromDatabase() {
    return Future.value(paymentMethodDao.getAllPaymentMethod());
  }

  @override
  Future<List<SnackVO>?> getSnackListFromDatabase() {
    return Future.value(snackDao.getAllSnackInfo());
  }

  @override
  Future<List<UserCardVO>?> getUserCardsFromDatabase() {
    return Future.value(userCardDao.getAllUserCards());
  }

  @override
  Future<CheckoutVO?> checkout(String token, CheckOutRequest request) {
    return _dataAgent.checkOut(token, request);
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    return _dataAgent.loginWithFacebook(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    return _dataAgent.loginWithGoogle(accessToken).then((value) async {
      UserDataVO user = value[2];
      user.userToken = value[3];
      userDataDao.saveUserData(user);
      return Future.value(value);
    });
  }
}
