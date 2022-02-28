import 'package:hive/hive.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

import '../../data/vos/cinema_list_for_hive_vo.dart';

class CinemaDayTimeslotDao {
  static final CinemaDayTimeslotDao _singleton =
      CinemaDayTimeslotDao._internal();

  factory CinemaDayTimeslotDao() {
    return _singleton;
  }

  CinemaDayTimeslotDao._internal();

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
