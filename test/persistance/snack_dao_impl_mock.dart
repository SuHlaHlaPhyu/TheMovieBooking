import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/persistance/daos/snack_dao.dart';

import '../mock_data/auth_mock_data.dart';

class SnackDaoImplMock extends SnackDao {
  Map<int, SnackVO> snackInMockDatabase = {};
  @override
  List<SnackVO> getAllSnackInfo() {
    return getMockSnack();
  }

  @override
  Stream<List<SnackVO>> getAllSnackInfoStream() {
    return Stream.value(getMockSnack());
  }

  @override
  Stream<void> getSnackListEventStream() {
    return Stream.value(null);
  }

  @override
  void saveAllSnackInfo(List<SnackVO> snackInfoList) {
    snackInfoList.forEach((element) {
      snackInMockDatabase[element.id ?? 0] = element;
    });
  }
}
