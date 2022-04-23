import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/snack_payment_bloc.dart';

import '../data/models/auth/auth_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';

void main(){
  group("snack payment bloc test", (){
    SnackPaymentBloc? snackPaymentBloc;

    setUp((){
      snackPaymentBloc = SnackPaymentBloc(AuthModelImplMock());
    });

    test("snack list test", (){
      expect(snackPaymentBloc?.snackList.contains(getMockSnack().first), true);
    });


    test("payment list test", (){
      expect(snackPaymentBloc?.paymentList?.contains(getMockPaymentMethods().first), true);
    });
  });
}