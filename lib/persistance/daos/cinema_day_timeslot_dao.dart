import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

import '../../data/vos/cinema_list_for_hive_vo.dart';

class CinemaDayTimeslotDao {
  static final CinemaDayTimeslotDao _singleton =
      CinemaDayTimeslotDao._internal();

  factory CinemaDayTimeslotDao() {
    return _singleton;
  }

  CinemaDayTimeslotDao._internal();

  //List<CinemaVO> cinemaVO = [];
  // void saveAllCinemaDayTimeslot(List<CinemaVO> timeslotList) async {
  //   Map<int, CinemaVO> timeslotMap = Map.fromIterable(timeslotList,
  //       key: (timeSlot) => timeSlot.cinemaId, value: (timeSlot) => timeSlot);
  //   await getCinemaDayTimeslotBox().putAll(timeslotMap);
  // }
  // void saveAllCinemaDayTimeslot(String date, List<CinemaVO> cinemaVO) async {
  //   await getCinemaDayTimeslotBox().put(date, cinemaVO);
  // }
  // List<CinemaVO> getAllCinemaDayTimeslot(String date) {
  //   return getCinemaDayTimeslotBox().get(date, defaultValue: cinemaVO)
  //       as List<CinemaVO>;
  // }
  // Box<List<CinemaVO>> getCinemaDayTimeslotBox() {
  //   return Hive.box<List<CinemaVO>>(BOX_NAME_TIMESLOT_VO);
  // }

  void saveAllCinemaDayTimeslot(
      String date, CinemaListForHiveVO cinemaVO) async {
    await getCinemaDayTimeslotBox().put(date, cinemaVO);
  }

  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    return getCinemaDayTimeslotBox().get(date);
  }

  Box<CinemaListForHiveVO> getCinemaDayTimeslotBox() {
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  }
}
