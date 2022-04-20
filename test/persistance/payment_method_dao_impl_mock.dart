import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/persistance/daos/payment_method_dao.dart';

class PaymentMethodDaoImplMock extends PaymentMethodDao{
  @override
  List<PaymentVO> getAllPaymentMethod() {
    // TODO: implement getAllPaymentMethod
    throw UnimplementedError();
  }

  @override
  Stream<List<PaymentVO>> getAllPaymentMethodStream() {
    // TODO: implement getAllPaymentMethodStream
    throw UnimplementedError();
  }

  @override
  Stream<void> getPaymentMethodEventStream() {
    // TODO: implement getPaymentMethodEventStream
    throw UnimplementedError();
  }

  @override
  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList) {
    // TODO: implement saveAllPaymentMethod
  }
  
}