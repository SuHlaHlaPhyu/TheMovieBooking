import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/cinema_vo.dart';
import 'package:collection/collection.dart';

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

  MovieChooseTimeBloc() {
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

    // // set False to all
    // cinemaList.map((cinema) {
    //   cinema.timeslots?.map((time) {
    //     time.isSelected = false;
    //   }).toList();
    // }).toList();
    // // set True to selected Time for color change
    // cinemaList[cinemaIndex].timeslots?[selectedTime!].isSelected = true;

    // var newList = cinemaList.map(
    //   (cinema) {
    //     cinema.timeslots?.map((time) {
    //       time.isSelected = false;
    //       return time;
    //     }).toList();
    //     return cinema;
    //   },
    // ).mapIndexed(
    //   (index, element) {
    //     element.timeslots?[index].isSelected = true;
    //   },
    // ).toList();

    // List<CinemaVO> newList = cinemaList.map((cinema) {
    //   cinema.timeslots?.map((time) {
    //     time.isSelected = false;
    //     return time;
    //   }).mapIndexed((index, element) {
    //     element.isSelected = true;
    //   }).toList();
    //   return cinema;
    // }).toList();
    // cinemaList = newList;
    notifyListeners();
  }
}
