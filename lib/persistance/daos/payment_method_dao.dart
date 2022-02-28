import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class PaymentMethodDao {
  static final PaymentMethodDao _singleton = PaymentMethodDao._internal();

  factory PaymentMethodDao() {
    return _singleton;
  }

  PaymentMethodDao._internal();

  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, PaymentVO> paymentMap = Map.fromIterable(paymentMethodList,
        key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentMethodBox().putAll(paymentMap);
  }

  List<PaymentVO> getAllPaymentMethod() {
    return getPaymentMethodBox().values.toList();
  }

  Box<PaymentVO> getPaymentMethodBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }
}
