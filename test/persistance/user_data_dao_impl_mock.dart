import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/persistance/daos/user_data_dao.dart';

class UserDataDaoImplMock extends UserDataDao{
  @override
  void clearUserData() {
    // TODO: implement clearUserData
  }

  @override
  UserDataVO? getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Stream<void> getUserDataEventStream() {
    // TODO: implement getUserDataEventStream
    throw UnimplementedError();
  }

  @override
  Stream<UserDataVO?> getUserDataStream() {
    // TODO: implement getUserDataStream
    throw UnimplementedError();
  }

  @override
  String? getUserToken() {
    // TODO: implement getUserToken
    throw UnimplementedError();
  }

  @override
  Stream<String?> getUserTokenStream() {
    // TODO: implement getUserTokenStream
    throw UnimplementedError();
  }

  @override
  void saveUserData(UserDataVO userData) {
    // TODO: implement saveUserData
  }
  
}