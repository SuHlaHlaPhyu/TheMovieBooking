import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/persistance/daos/user_data_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class UserDataDaoImpl extends UserDataDao{
  static final UserDataDaoImpl _singleton = UserDataDaoImpl._internal();

  factory UserDataDaoImpl() {
    return _singleton;
  }

  UserDataDaoImpl._internal();

  @override
  void saveUserData(UserDataVO userData) async {
    await getUserDataBox().put("user", userData);
  }

  @override
  UserDataVO? getUserData() {
    return getUserDataBox().get("user");
  }

  @override
  String? getUserToken() {
    return getUserData()?.userToken ?? "";
  }

  @override
  void clearUserData() async {
    await getUserDataBox().clear();
  }

  Box<UserDataVO> getUserDataBox() {
    return Hive.box<UserDataVO>(BOX_NAME_USER_DATA_VO);
  }

  /// reactive programming
  @override
  Stream<void> getUserDataEventStream() {
    return getUserDataBox().watch();
  }

  @override
  Stream<UserDataVO?> getUserDataStream() {
    return Stream.value(getUserData());
  }

  @override
  Stream<String?> getUserTokenStream() {
    return Stream.value(getUserToken());
  }
}
