import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class SnackDao {
  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao() {
    return _singleton;
  }

  SnackDao._internal();

  void saveAllSnackInfo(List<SnackVO> snackInfoList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, SnackVO> snackInfoMap = Map.fromIterable(snackInfoList,
        key: (snackInfo) => snackInfo.id, value: (snackInfo) => snackInfo);
    await getSnackInfoBox().putAll(snackInfoMap);
  }

  List<SnackVO> getAllSnackInfo() {
    return getSnackInfoBox().values.toList();
  }

  Box<SnackVO> getSnackInfoBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }

  /// reactive programming
  Stream<void> getSnackListEventStream() {
    return getSnackInfoBox().watch();
  }

  Stream<List<SnackVO>> getAllSnackInfoStream() {
    return Stream.value(getAllSnackInfo());
  }
}
