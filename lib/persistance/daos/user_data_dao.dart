import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class UserDataDao {
  static final UserDataDao _singleton = UserDataDao._internal();

  factory UserDataDao() {
    return _singleton;
  }

  UserDataDao._internal();

  void saveUserData(UserDataVO userData) async {
    await getUserDataBox().put("user", userData);
  }

  UserDataVO? getUserData() {
    return getUserDataBox().get("user");
  }

  String? getUserToken() {
    return getUserData()?.userToken ?? "";
  }

  void clearUserData() async {
    await getUserDataBox().clear();
  }

  // void clearUserData() async {
  //   await getUserDataBox().delete("user");
  // }

  Box<UserDataVO> getUserDataBox() {
    return Hive.box<UserDataVO>(BOX_NAME_USER_DATA_VO);
  }
}
