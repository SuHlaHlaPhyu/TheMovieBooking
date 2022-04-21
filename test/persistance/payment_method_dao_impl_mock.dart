import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/persistance/daos/payment_method_dao.dart';

import '../mock_data/auth_mock_data.dart';

class PaymentMethodDaoImplMock extends PaymentMethodDao{
  Map<int , PaymentVO> paymentInMockDatabase = {};
  @override
  List<PaymentVO> getAllPaymentMethod() {
    return getMockPaymentMethods();
  }

  @override
  Stream<List<PaymentVO>> getAllPaymentMethodStream() {
    return Stream.value(getMockPaymentMethods());
  }

  @override
  Stream<void> getPaymentMethodEventStream() {
    return Stream.value(null);
  }

  @override
  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList) {
    paymentMethodList.forEach((element) {
      paymentInMockDatabase[element.id ?? 0] = element;
    });
  }
  
}