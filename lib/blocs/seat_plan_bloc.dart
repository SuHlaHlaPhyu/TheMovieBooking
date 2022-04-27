import 'package:flutter/foundation.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/seating_plan_vo.dart';
import '../resources/string.dart';
import 'package:collection/collection.dart';

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

  SeatPlanBloc(int timeslot, String date , [AuthModel? authModelTest]) {
    /// mock
    if(authModelTest != null){
      authModel = authModelTest;
    }
    ///
    authModel.getCinemaSeatingPlan(timeslot, date).then((user) {
      rawseatPlan = user;
      seatPlan = rawseatPlan!.expand((element) => element).toList();
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  /// object
  // void onTapMovieSeatSection(SeatingPlanVO selectedSeat) {
  //   if (selectedSeat.type == SEAT_TYPE_AVAILABLE) {
  //     String name = selectedSeat.seatName!;
  //     row = selectedSeat.symbol;
  //
  //     var newList = seatPlan.map((item) {
  //       if (item == selectedSeat) {
  //         if (item.isSelected == true) {
  //           item.isSelected = false;
  //           totalPrice -= item.price!;
  //           totalTickets -= 1;
  //         } else if (item.isSelected == false) {
  //           item.isSelected = true;
  //           totalPrice += item.price!;
  //           totalTickets += 1;
  //         }
  //       }
  //       return item;
  //     }).toList();
  //     seatPlan = newList;
  //     if (seatName.contains(name)) {
  //       seatName.remove(name);
  //     } else {
  //       seatName.add(name);
  //     }
  //     notifyListeners();
  //   }
  // }

  void selectedMovieSeatSection(int? selectedIndex) {
    if (seatPlan[selectedIndex!].type == SEAT_TYPE_AVAILABLE) {
      String name = seatPlan[selectedIndex].seatName!;
      row = seatPlan[selectedIndex].symbol;
      var newList = seatPlan.mapIndexed((index, element) {
        if (selectedIndex == index) {
          if (element.isSelected == true) {
            element.isSelected = false;
            totalPrice -= element.price!;
            totalTickets -= 1;
          } else {
            element.isSelected = true;
            totalPrice += element.price!;
            totalTickets += 1;
          }
        }
        return element;
      }).toList();
      seatPlan = newList;
      if (seatName.contains(name)) {
        seatName.remove(name);
      } else {
        seatName.add(name);
      }
      notifyListeners();
    }
  }
}

