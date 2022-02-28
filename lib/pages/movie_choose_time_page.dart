import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/timeslot_vo.dart';
import 'package:movie_booking/pages/seat_plan_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:intl/intl.dart';

class MovieChooseTimePage extends StatefulWidget {
  MovieVO? movie;
  MovieChooseTimePage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieChooseTimePageState createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  AuthModel authModel = AuthModelImpl();
  List<CinemaVO>? cinemaList;
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedCinema, selectedMovieTime;
  CinemaVO? cinema;
  int? timeslotId;
  @override
  void initState() {
    // time slots
    authModel.getUserTokenfromDatabase().then((value) {
      authModel
          .getCinemaDayTimeSlot("Bearer " + value, selectedDate)
          .then((cinema) {
        setState(() {
          cinemaList = cinema ?? [];
          print("time slot from network $cinemaList");
        });

        authModel.getCinemaDayTimeSlotFromDataBase(selectedDate).then((cinema) {
          setState(() {
            cinemaList = cinema ?? [];
            print("time slot from db $cinemaList");
          });
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });

    /// from db
    // authModel.getCinemaDayTimeSlotFromDataBase(selectedDate).then((cinema) {
    //   setState(() {
    //     cinemaList = cinema ?? [];
    //     print("time slot from db $cinemaList");
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: PRIMARY_COLOR,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieChooseDateView(
                onSelected: (selectDate) {
                  selectedDate = selectDate!;
                  selectedMovieTime = "";
                  authModel.getUserTokenfromDatabase().then((value) {
                    authModel
                        .getCinemaDayTimeSlot("Bearer " + value, selectDate)
                        .then((cinema) {
                      setState(() {
                        cinemaList = cinema;
                      });
                    }).catchError((error) {
                      debugPrint(error.toString());
                    });
                  });

                  /// from db
                  authModel
                      .getCinemaDayTimeSlotFromDataBase(selectedDate)
                      .then((cinema) {
                    setState(() {
                      cinemaList = cinema;
                    });
                  }).catchError((error) {
                    debugPrint(error.toString());
                  });
                },
              ),
              ChooseItemGridSectionView(
                cinemaList: cinemaList ?? [],
                onSelected: (cinemaIndex, selectedTime) {
                  timeslotId = cinemaList?[cinemaIndex!]
                      .timeslots?[selectedTime!]
                      .cinemaDayTimeslotId;
                  cinema = cinemaList![cinemaIndex!];
                  selectedCinema = cinemaList?[cinemaIndex].cinema;
                  selectedMovieTime = cinemaList?[cinemaIndex]
                      .timeslots?[selectedTime!]
                      .startTime;
                  setState(() {
                    // set False to all
                    cinemaList?.map((cinema) {
                      cinema.timeslots?.map((time) {
                        time.isSelected = false;
                      }).toList();
                    }).toList();

                    // set True to selected Time
                    cinemaList?[cinemaIndex]
                        .timeslots?[selectedTime!]
                        .isSelected = true;
                  });
                },
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
        ),
        child: GestureDetector(
          onTap: () {
            if (selectedMovieTime == null || selectedMovieTime == "") {
            } else {
              _navigateToSeatPlanPage(context, widget.movie, selectedDate,
                  selectedMovieTime!, selectedCinema!, cinema!, timeslotId!);
            }
          },
          child: AppTextButton(
            "Next",
            btnColor: selectedMovieTime == null || selectedMovieTime == ""
                ? Colors.grey
                : PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}

void _navigateToSeatPlanPage(BuildContext context, MovieVO? movie, String date,
    String time, String cinemaName, CinemaVO cinema, int dayTimeslot) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SeatPlanPage(
        movieName: movie,
        date: date,
        time: time,
        cinemaName: cinemaName,
        cinema: cinema,
        timelsot: dayTimeslot,
      ),
    ),
  );
}

class ChooseItemGridSectionView extends StatelessWidget {
  List<CinemaVO> cinemaList;
  Function(int?, int?) onSelected;
  ChooseItemGridSectionView(
      {required this.cinemaList, required this.onSelected});
  // List<String> seatList = [
  //   '2D',
  //   '3D',
  // ];

  // List<String> timeList = [
  //   '9:30 AM',
  //   '11:45 AM',
  //   '3:30 PM',
  //   '5:00 PM',
  //   '7:00 PM',
  //   '9:30 PM',
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        left: MARGIN_MEDIUM_2,
        right: MARGIN_MEDIUM_2,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cinemaList
            .asMap()
            .map(
              (i, value) => MapEntry(
                i,
                ChooseItemGridView(
                  text: value.cinema,
                  timeSlot: value.timeslots,
                  onSelected: (selectedTime) => onSelected(
                    i,
                    selectedTime,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}

// map(
//               (cinema) => ChooseItemGridView(
//                 text: cinema.cinema,
//                 timeSlot: cinema.timeslots,
//                 onSelected: (selectedTime) =>
//                     onSelected(cinema.cinemaId, selectedTime),
//               ),
//             )
//             .toList(),

class ChooseItemGridView extends StatelessWidget {
  final String? text;
  final List<TimeslotVO>? timeSlot;
  Function(int?) onSelected;
  ChooseItemGridView({
    required this.text,
    required this.timeSlot,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        GridView.builder(
          itemCount: timeSlot?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSelected(index);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: MARGIN_MEDIUM_2,
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                ),
                decoration: BoxDecoration(
                  color: timeSlot?[index].isSelected == true
                      ? PRIMARY_COLOR
                      : Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(
                    MARGIN_MEDIUM,
                  ),
                ),
                child: Center(
                  child: Text(
                    timeSlot?[index].startTime ?? "",
                    style: TextStyle(
                      color: timeSlot?[index].isSelected == true
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// class MovieChooseDateView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MOVIE_CHOOSE_DATE_HIGHT,
//       color: PRIMARY_COLOR,
//       child: ListView.separated(
//           separatorBuilder: (context, index) {
//             return const SizedBox(
//               width: MARGIN_MEDIUM_2,
//             );
//           },
//           padding: const EdgeInsets.symmetric(
//             horizontal: MARGIN_MEDIUM_2,
//           ),
//           scrollDirection: Axis.horizontal,
//           itemCount: 20,
//           itemBuilder: (context, index) {
//             return Column(
//               children: const [
//                 Text(
//                   'Wed',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: TEXT_REGULAR_3X,
//                   ),
//                 ),
//                 SizedBox(
//                   height: MARGIN_MEDIUM_2,
//                 ),
//                 Text(
//                   '10',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: TEXT_REGULAR_3X,
//                   ),
//                 )
//               ],
//             );
//           }),
//     );
//   }
// }
class MovieChooseDateView extends StatelessWidget {
  Function(String?) onSelected;
  MovieChooseDateView({required this.onSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_CHOOSE_DATE_HIGHT,
      color: PRIMARY_COLOR,
      child: CalendarWeek(
        height: 100,
        minDate: DateTime.now().add(
          const Duration(days: -365),
        ),
        maxDate: DateTime.now().add(
          const Duration(days: 365),
        ),
        onDatePressed: (DateTime datetime) {
          String date = DateFormat('yyyy-MM-dd').format(datetime);
          onSelected(date);
        },
        onDateLongPressed: (DateTime datetime) {},
      ),
    );
  }
}
