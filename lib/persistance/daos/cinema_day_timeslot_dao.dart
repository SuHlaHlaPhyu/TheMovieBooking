import '../../data/vos/cinema_list_for_hive_vo.dart';

abstract class CinemaDayTimeslotDao {
  void saveAllCinemaDayTimeslot(
      String date, CinemaListForHiveVO cinemaVO);

  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date);


  /// reactive programming
  Stream<void> getCinemaEventStream();

  Stream<CinemaListForHiveVO?> getAllCinemaDayTimeslotStream(String date);
}
