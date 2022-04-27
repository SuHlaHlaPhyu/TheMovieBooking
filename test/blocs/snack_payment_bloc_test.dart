import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/snack_payment_bloc.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';

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


    test("selected payment methods",() async{
      snackPaymentBloc?.selectedPaymentMethods(0);
      await Future.delayed(const Duration(milliseconds: 3));
      expect(snackPaymentBloc?.selectPayment, 'Credit card');
    });
    
    test("add quantity test", () async{
      snackPaymentBloc?.addQuantity(SnackVO(1, "Popcorn", 2, "Et dolores eaque officia aut.", null, 1,
          null, null));
      await Future.delayed(const Duration(milliseconds: 3));
      expect(snackPaymentBloc?.grandTotal, 11.0);
    });

    test("subtract quantity test", () async{
      snackPaymentBloc?.subtractQuantity(SnackVO(2, "Smoothies", 3, "Et dolores eaque officia aut.", null, 1,
          null, null));
      await Future.delayed(const Duration(milliseconds: 3));
      expect(snackPaymentBloc?.grandTotal, 6.0);
    });
  });
}