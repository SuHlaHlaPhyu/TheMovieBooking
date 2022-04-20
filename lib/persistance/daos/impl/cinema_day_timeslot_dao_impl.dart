import 'package:hive/hive.dart';
import 'package:movie_booking/persistance/daos/cinema_day_timeslot_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

import '../../../data/vos/cinema_list_for_hive_vo.dart';


class CinemaDayTimeslotDaoImpl extends CinemaDayTimeslotDao{
  static final CinemaDayTimeslotDaoImpl _singleton =
  CinemaDayTimeslotDaoImpl._internal();

  factory CinemaDayTimeslotDaoImpl() {
    return _singleton;
  }

  CinemaDayTimeslotDaoImpl._internal();

  @override
  void saveAllCinemaDayTimeslot(
      String date, CinemaListForHiveVO cinemaVO) async {
    await getCinemaDayTimeslotBox().put(date, cinemaVO);
  }

  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    return getCinemaDayTimeslotBox().get(date);
  }

  Box<CinemaListForHiveVO> getCinemaDayTimeslotBox() {
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  }

  /// reactive programming
  @override
  Stream<void> getCinemaEventStream() {
    return getCinemaDayTimeslotBox().watch();
  }

  @override
  Stream<CinemaListForHiveVO?> getAllCinemaDayTimeslotStream(String date) {
    return Stream.value(getAllCinemaDayTimeslot(date));
  }

// void saveAllCinemaDayTimeslot(List<CinemaVO> cinemaList, String date) async {
//   List<CinemaVO> updatedCinemaList = cinemaList.map((cinema) {
//     CinemaVO? cinemaFromHive = getCinemaById(cinema.cinemaId ?? 1);
//     if (cinemaFromHive == null) {
//       return cinema;
//     } else {
//       cinemaFromHive.dates?.add(date);
//       return cinemaFromHive;
//     }
//   }).toList();
//   // ignore: prefer_for_elements_to_map_fromiterable
//   Map<int, CinemaVO> cinemaMap = Map.fromIterable(updatedCinemaList,
//       key: (cinema) => cinema.cinemaId, value: (cinema) => cinema);
//   await getCinemaDayTimeslotBox().putAll(cinemaMap);
//   print("cinema list save successfully $cinemaMap");
// }

// CinemaVO? getCinemaById(int cinemaId) {
//   return getCinemaDayTimeslotBox().get(cinemaId);
// }

// Box<CinemaVO> getCinemaDayTimeslotBox() {
//   return Hive.box<CinemaVO>(BOX_NAME_TIMESLOT_VO);
// }
}
