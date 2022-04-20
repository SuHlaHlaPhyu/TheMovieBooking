import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/persistance/daos/cinema_day_timeslot_dao.dart';

class CinemaDayTimeslotImplMock extends CinemaDayTimeslotDao{
  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    // TODO: implement getAllCinemaDayTimeslot
    throw UnimplementedError();
  }

  @override
  Stream<CinemaListForHiveVO?> getAllCinemaDayTimeslotStream(String date) {
    // TODO: implement getAllCinemaDayTimeslotStream
    throw UnimplementedError();
  }

  @override
  Stream<void> getCinemaEventStream() {
    // TODO: implement getCinemaEventStream
    throw UnimplementedError();
  }

  @override
  void saveAllCinemaDayTimeslot(String date, CinemaListForHiveVO cinemaVO) {
    // TODO: implement saveAllCinemaDayTimeslot
  }
  
}