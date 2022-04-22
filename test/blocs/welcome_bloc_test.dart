import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/welcome_bloc.dart';

import '../data/models/movie/auth_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';

void main(){
  group("userdata bloc test", (){
    WelcomeBloc? welcomeBloc;

    setUp((){
      welcomeBloc = WelcomeBloc(AuthModelImplMock());
    });

    test("user data test", (){
      expect(welcomeBloc?.userData, getUserDataMockTest());
    });

  });
}