import 'package:movie_booking/data/vos/snack_vo.dart';

abstract class SnackDao {

  void saveAllSnackInfo(List<SnackVO> snackInfoList);

  List<SnackVO> getAllSnackInfo();

  /// reactive programming
  Stream<void> getSnackListEventStream();

  Stream<List<SnackVO>> getAllSnackInfoStream();
}
