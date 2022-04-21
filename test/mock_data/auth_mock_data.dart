import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
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
      CinemaVO(1, "Cinema I", [], []),
      CinemaVO(2, "Cinema II", [], []),
      CinemaVO(3, "Cinema III", [], [])
    ],
  );
}

List<SeatingPlanVO> getMockSeatPlan(){
  return [
    SeatingPlanVO(1, "text", 0, "A-4", "A", false),
    SeatingPlanVO(1, "text", 0, "B-1", "B", false),
    SeatingPlanVO(1, "text", 0, "C-2", "C", false),
    SeatingPlanVO(1, "text", 0, "D-1", "D", false),
  ];
}

List<SnackVO> getMockSnack() {
  return [
    SnackVO(1, "Popcorn", null, "Et dolores eaque officia aut.", null, null, null, null),
    SnackVO(2, "Smoothies", null, "Et dolores eaque officia aut.", null, null, null, null),
    SnackVO(3, "Carrots", null, "Et dolores eaque officia aut.", null, null, null, null),
  ];
}
