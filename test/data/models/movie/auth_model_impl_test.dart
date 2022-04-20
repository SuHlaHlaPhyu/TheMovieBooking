import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';

import '../../../mock_data/auth_mock_data.dart';
import '../../../network/auth/auth_data_agent_impl_mock.dart';
import '../../../persistance/user_data_dao_impl_mock.dart';

void main() {
  group("auth model impl test", () {
    var authModel = AuthModelImpl();

    setUp(() {
      authModel.setDaosAndDataAgents(
        UserDataDaoImplMock(),
        AuthDataAgentImplMock(),
      );
    });

    test("user data test", () {
      expect(
          authModel.getUserDatafromDatabase(),
          emits(
            getUserDataMockTest(),
          ));
    });
  });
}
