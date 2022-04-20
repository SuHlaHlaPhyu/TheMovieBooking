import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/persistance/daos/snack_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class SnackDaoImpl extends SnackDao{
  static final SnackDaoImpl _singleton = SnackDaoImpl._internal();

  factory SnackDaoImpl() {
    return _singleton;
  }

  SnackDaoImpl._internal();

  @override
  void saveAllSnackInfo(List<SnackVO> snackInfoList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, SnackVO> snackInfoMap = Map.fromIterable(snackInfoList,
        key: (snackInfo) => snackInfo.id, value: (snackInfo) => snackInfo);
    await getSnackInfoBox().putAll(snackInfoMap);
  }

  @override
  List<SnackVO> getAllSnackInfo() {
    return getSnackInfoBox().values.toList();
  }

  Box<SnackVO> getSnackInfoBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }

  /// reactive programming
  @override
  Stream<void> getSnackListEventStream() {
    return getSnackInfoBox().watch();
  }

  @override
  Stream<List<SnackVO>> getAllSnackInfoStream() {
    return Stream.value(getAllSnackInfo());
  }
}
