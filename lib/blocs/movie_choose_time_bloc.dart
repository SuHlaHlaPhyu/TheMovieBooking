import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/cinema_vo.dart';

class MovieChooseTimeBloc extends ChangeNotifier {
  /// state
  List<CinemaVO> cinemaList = [];
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedCinema, selectedMovieTime;
  CinemaVO? cinema;
  int? timeslotId;
  String selectedDate = "";

  /// model
  AuthModel authModel = AuthModelImpl();

  MovieChooseTimeBloc([AuthModel? authModelTest]) {
    /// mock
    if(authModelTest != null){
      authModel = authModelTest;
    }
    
    ///
    authModel.getCinemaDayTimeSlotFromDataBase(currentDate).listen((cinema) {
      cinemaList = cinema ?? [];
      selectedDate = currentDate;
      notifyListeners();
    }).onError((error) {});
  }

  void getTimeSlotbyDate(String date) {
    selectedDate = date;
    authModel.getCinemaDayTimeSlotFromDataBase(date).listen((cinema) {
      cinemaList = cinema ?? [];
      notifyListeners();
    }).onError((error) {});
  }

  void chooseItemGrid(int? cinemaIndex, int? selectedTime) {
    timeslotId =
        cinemaList[cinemaIndex!].timeslots?[selectedTime!].cinemaDayTimeslotId;
    cinema = cinemaList[cinemaIndex];
    selectedCinema = cinemaList[cinemaIndex].cinema;
    selectedMovieTime =
        cinemaList[cinemaIndex].timeslots?[selectedTime!].startTime;

    List<CinemaVO> newList = cinemaList.map((cinema) {
      cinema.timeslots?.map((e) {
        e.isSelected = false;
        return cinema;
      }).toList();
      cinemaList[cinemaIndex].timeslots?[selectedTime!].isSelected = true;
      return cinema;
    }).toList();
    cinemaList = newList;
    notifyListeners();

    ///
    notifyListeners();
  }
}
