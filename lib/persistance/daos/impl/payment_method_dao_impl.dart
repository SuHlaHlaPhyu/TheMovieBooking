import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/persistance/daos/payment_method_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class PaymentMethodDaoImpl extends PaymentMethodDao{
  static final PaymentMethodDaoImpl _singleton = PaymentMethodDaoImpl._internal();

  factory PaymentMethodDaoImpl() {
    return _singleton;
  }

  PaymentMethodDaoImpl._internal();

  @override
  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, PaymentVO> paymentMap = Map.fromIterable(paymentMethodList,
        key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentMethodBox().putAll(paymentMap);
  }

  @override
  List<PaymentVO> getAllPaymentMethod() {
    return getPaymentMethodBox().values.toList();
  }

  Box<PaymentVO> getPaymentMethodBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }

  /// reactive programming
  @override
  Stream<void> getPaymentMethodEventStream() {
    return getPaymentMethodBox().watch();
  }

  @override
  Stream<List<PaymentVO>> getAllPaymentMethodStream() {
    return Stream.value(getAllPaymentMethod());
  }
}
