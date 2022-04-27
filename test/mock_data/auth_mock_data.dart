import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/timeslot_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';

UserDataVO getUserDataMockTest() => UserDataVO(
      445,
      [],
      "shhphyu@gmail.com",
      "Su",
      "959987654345",
      null,
      null,
      null,
    );

CinemaListForHiveVO getMockCinemaTimeslot() {
  return CinemaListForHiveVO(
    [
      CinemaVO(1, "Cinema I", [TimeslotVO(1, "10:00 AM", true)], ["22-4-2022"]),
      CinemaVO(2, "Cinema II", [], []),
      CinemaVO(3, "Cinema III", [], [])
    ],
  );
}

List<SeatingPlanVO> getMockSeatPlan() {
  return [
    SeatingPlanVO(1, "available", 2, "A-4", "A", false),
    SeatingPlanVO(1, "available", 2, "B-1", "B", false),
    SeatingPlanVO(1, "available", 2, "C-2", "C", false),
    SeatingPlanVO(1, "available", 2, "D-1", "D", false),
  ];
}

List<SnackVO> getMockSnack() {
  return [
    SnackVO(1, "Popcorn", 2, "Et dolores eaque officia aut.", null, 1,
        null, null),
    SnackVO(2, "Smoothies", 3, "Et dolores eaque officia aut.", null, 1,
        null, null),
    SnackVO(3, "Carrots", 4, "Et dolores eaque officia aut.", null, 1,
        null, null),
  ];
}

List<PaymentVO> getMockPaymentMethods() {
  return [
    PaymentVO(1, "Credit card", null, null),
    PaymentVO(2, "Internet Banking (ATM card)", null, null),
    PaymentVO(3, "E-Wallet", null, null),
  ];
}

List<UserCardVO> getMockUserCard() {
  return [
    UserCardVO(1, "Su", null, null, null),
    UserCardVO(2, "Hla", null, null, null),
    UserCardVO(3, "Phyu", null, null, null)
  ];
}
