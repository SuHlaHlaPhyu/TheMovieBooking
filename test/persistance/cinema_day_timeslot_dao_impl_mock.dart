import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/persistance/daos/cinema_day_timeslot_dao.dart';

import '../mock_data/auth_mock_data.dart';

class CinemaDayTimeslotImplMock extends CinemaDayTimeslotDao{
  Map< String , CinemaListForHiveVO> cinemaListInMock = {};
  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    return getMockCinemaTimeslot();
  }

  @override
  Stream<CinemaListForHiveVO?> getAllCinemaDayTimeslotStream(String date) {
    return Stream.value(getMockCinemaTimeslot());
  }

  @override
  Stream<void> getCinemaEventStream() {
    return Stream<void>.value(null);
  }

  @override
  void saveAllCinemaDayTimeslot(String date, CinemaListForHiveVO cinemaVO) {
    cinemaListInMock [date] = cinemaVO;
  }
  
}