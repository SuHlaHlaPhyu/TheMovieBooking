import 'package:movie_booking/data/vos/payment_vo.dart';

abstract class PaymentMethodDao {

  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList);

  List<PaymentVO> getAllPaymentMethod();

  /// reactive programming
  Stream<void> getPaymentMethodEventStream();

  Stream<List<PaymentVO>> getAllPaymentMethodStream();
}
