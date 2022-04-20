import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

part 'cinema_list_for_hive_vo.g.dart';

@HiveType(
    typeId: HIVE_TYPE_ID_CINEMA_LIST_FOR_HIVE_VO,
    adapterName: "CinemaListForHiveVOAdapter")
class CinemaListForHiveVO {
  @HiveField(0)
  List<CinemaVO>? cinemaList;

  CinemaListForHiveVO(
    this.cinemaList,
  );
  @override
  String toString() {
    return 'CinemaListForHiveVO{cinemaList: $cinemaList,}';
  }

  @override
  int get hashCode => cinemaList.hashCode;

  @override
  bool operator ==(Object other) {
    return other is CinemaListForHiveVO && const ListEquality().equals(cinemaList, other.cinemaList) ;
  }
}
