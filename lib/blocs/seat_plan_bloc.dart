import 'package:flutter/foundation.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/seating_plan_vo.dart';
import '../resources/string.dart';

class SeatPlanBloc extends ChangeNotifier {
  /// states
  String? row;
  List<List<SeatingPlanVO>>? rawseatPlan;
  List<SeatingPlanVO> seatPlan = [];
  double totalPrice = 0;
  int totalTickets = 0;
  List<String> seatName = [];

  /// model
  AuthModel authModel = AuthModelImpl();

  SeatPlanBloc(int timeslot, String date) {
    authModel.getCinemaSeatingPlan(timeslot, date).then((user) {
      rawseatPlan = user;
      seatPlan = rawseatPlan!.expand((element) => element).toList();
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void selectedMovieSeatSection(int? index) {
    if (seatPlan[index!].type == SEAT_TYPE_AVAILABLE) {
      String name = seatPlan[index].seatName!;
      row = seatPlan[index].symbol;
      if (seatPlan[index].isSelected == true) {
        seatPlan[index].isSelected = false;
        totalPrice -= seatPlan[index].price!;
        totalTickets -= 1;
        notifyListeners();
      } else {
        seatPlan[index].isSelected = true;
        totalPrice += seatPlan[index].price!;
        totalTickets += 1;
        notifyListeners();
      }
      if (seatName.contains(name)) {
        seatName.remove(name);
        notifyListeners();
      } else {
        seatName.add(name);
        notifyListeners();
      }
      notifyListeners();
    }
  }
}
