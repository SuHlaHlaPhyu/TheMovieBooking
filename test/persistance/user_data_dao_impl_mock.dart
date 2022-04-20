import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/persistance/daos/user_data_dao.dart';

import '../mock_data/auth_mock_data.dart';

class UserDataDaoImplMock extends UserDataDao {
  Map<int?, UserDataVO> userDataInDatabaseMock = {};
  @override
  void clearUserData() {
    //
  }

  @override
  UserDataVO? getUserData() {
    return getUserDataMockTest();
  }

  @override
  Stream<void> getUserDataEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<UserDataVO?> getUserDataStream() {
    return Stream.value(getUserDataMockTest());
  }

  @override
  String? getUserToken() {
    return "";
  }

  @override
  Stream<String?> getUserTokenStream() {
    return Stream.value("");
  }

  @override
  void saveUserData(UserDataVO userData) {
    userDataInDatabaseMock [userData.id] = userData;
  }
}
