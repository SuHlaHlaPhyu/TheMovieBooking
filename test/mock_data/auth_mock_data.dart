import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
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


