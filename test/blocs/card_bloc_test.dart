import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/card_bloc.dart';

import '../data/models/auth/auth_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';

void main(){
  group("card bloc test", (){
    CardBloc? cardBloc;

    setUp((){
      cardBloc = CardBloc(AuthModelImplMock());
    });

    test("card list test", (){
      expect(cardBloc?.cardList?.contains(getMockUserCard().first), true);
    });

  });
}