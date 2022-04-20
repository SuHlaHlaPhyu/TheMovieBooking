import 'package:movie_booking/data/vos/user_data_vo.dart';

abstract class UserDataDao {

  void saveUserData(UserDataVO userData);

  UserDataVO? getUserData();

  String? getUserToken();

  void clearUserData();

  /// reactive programming
  Stream<void> getUserDataEventStream();

  Stream<UserDataVO?> getUserDataStream();

  Stream<String?> getUserTokenStream();
}
