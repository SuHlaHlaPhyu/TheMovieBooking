import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/data/models/auth/auth_model.dart';
import 'package:movie_booking/data/models/auth/auth_model_impl.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/pages/snack_info_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/ticket_info_row.dart';

class SeatPlanPage extends StatefulWidget {
  MovieVO? movieName;
  final String date;
  String? time;
  String? cinemaName;
  CinemaVO cinema;
  int timelsot;
  SeatPlanPage({
    Key? key,
    required this.movieName,
    required this.date,
    required this.time,
    required this.cinemaName,
    required this.cinema,
    required this.timelsot,
  }) : super(key: key);

  @override
  _SeatPlanPageState createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  AuthModel authModel = AuthModelImpl();
  String? row;
  List<List<SeatingPlanVO>>? rawseatPlan;
  List<SeatingPlanVO> seatPlan = [];
  double totalPrice = 0;
  int totalTickets = 0;
  List<String> seatName = [];

  @override
  void initState() {
    authModel.getCinemaSeatingPlan(widget.timelsot, widget.date).then((user) {
      setState(() {
        rawseatPlan = user;
        seatPlan = rawseatPlan!.expand((element) => element).toList();
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              MovieTimeAndCinemaSectionView(
                movieName: widget.movieName?.title,
                cinemaName: widget.cinemaName,
                date: widget.date,
                time: widget.time,
              ),
              const SizedBox(
                height: 20.0,
              ),
              MovieSeatSectionView(
                movieSeats: seatPlan,
                onSelected: (index) {
                  selectedMovieSeatSection(index);
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              MovieSeatGlosserySectionView(),
              const SizedBox(
                height: 20.0,
              ),
              const DottedLineSectionView(),
              const SizedBox(
                height: 20.0,
              ),
              TicketAndSeatInfoSectionView(
                ticketsCount: totalTickets,
                seatName: seatName.join(","),
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
            goToNextPage(context);
          },
          child: AppTextButton(
            "Buy Ticket for \$ $totalPrice",
            btnColor: seatName.isEmpty ? Colors.grey : PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context) {
    if (seatName.isNotEmpty) {
      _navigateToSnackInfoPage(
          context,
          widget.movieName!,
          widget.date,
          widget.time!,
          widget.cinemaName!,
          widget.cinema,
          totalPrice,
          row!,
          seatName.join(","),
          widget.timelsot);
    }
  }

  void selectedMovieSeatSection(int? index) {
    if (seatPlan[index!].type == SEAT_TYPE_AVAILABLE) {
      String name = seatPlan[index].seatName!;
      row = seatPlan[index].symbol;

      if (seatPlan[index].isSelected == true) {
        setState(() {
          seatPlan[index].isSelected = false;
          totalPrice -= seatPlan[index].price!;
          totalTickets -= 1;
        });
      } else {
        setState(() {
          seatPlan[index].isSelected = true;
          totalPrice += seatPlan[index].price!;
          totalTickets += 1;
        });
      }
      if (seatName.contains(name)) {
        seatName.remove(name);
      } else {
        seatName.add(name);
      }
    }
  }
}

void _navigateToSnackInfoPage(
    BuildContext context,
    MovieVO movie,
    String date,
    String time,
    String cinemaName,
    CinemaVO cinema,
    double total,
    String row,
    String seat,
    int timeslot) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SnackInfoPage(
        movieName: movie,
        date: date,
        time: time,
        cinemaName: cinemaName,
        cinema: cinema,
        totalCost: total,
        row: row,
        seat: seat,
        timeslot: timeslot,
      ),
    ),
  );
}

class DottedLineSectionView extends StatelessWidget {
  const DottedLineSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
      ),
      child: const DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: MARGIN_MEDIUM,
        dashColor: Colors.black26,
        dashGapLength: MARGIN_MEDIUM,
        dashGapColor: Colors.transparent,
        dashGapRadius: 0.0,
      ),
    );
  }
}

class MovieSeatGlosserySectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MovieSeatGlosseryView(
              'Available',
              Colors.black12,
            ),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlosseryView(
              'Taken',
              Colors.grey,
            ),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlosseryView(
              'Your Selection',
              PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSeatGlosseryView extends StatelessWidget {
  final String text;
  final Color color;
  MovieSeatGlosseryView(
    this.text,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MOVIE_SEAT_GLOSSERY_SIZE,
          width: MOVIE_SEAT_GLOSSERY_SIZE,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}

class MovieSeatSectionView extends StatelessWidget {
  final List<SeatingPlanVO> movieSeats;
  final Function(int?) onSelected;
  MovieSeatSectionView({
    required this.movieSeats,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieSeats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return MovieSeatItemView(
          movieSeats: movieSeats[index],
          onSelected: () {
            onSelected(index);
          },
        );
      },
    );
  }
}

class MovieSeatItemView extends StatelessWidget {
  final SeatingPlanVO movieSeats;
  final Function onSelected;
  MovieSeatItemView({
    required this.movieSeats,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // select seat
        onSelected();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: MARGIN_SMALL_2,
          vertical: MARGIN_SMALL_2,
        ),
        decoration: BoxDecoration(
          color: movieSeats.isSelected == true
              ? PRIMARY_COLOR
              : _getSeatColor(movieSeats),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              MARGIN_MEDIUM,
            ),
            topRight: Radius.circular(
              MARGIN_MEDIUM,
            ),
          ),
        ),
        child: movieSeats.type == "text"
            ? Text(
                movieSeats.symbol ?? "",
              )
            : movieSeats.isSelected == true
                ? Center(
                    child: Text(
                      movieSeats.symbol ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  )
                : const Text(""),
      ),
    );
  }

  Color _getSeatColor(SeatingPlanVO movieSeat) {
    if (movieSeat.isMovieSeatTaken()) {
      return MOVIE_SEAT_TAKEN_COLOR;
    } else if (movieSeat.isMovieSeatAvailable()) {
      return MOVIE_SEAT_AVAILABLE_COLOR;
    } else {
      return Colors.white;
    }
  }
}

class TicketAndSeatInfoSectionView extends StatelessWidget {
  int ticketsCount;
  String seatName;
  TicketAndSeatInfoSectionView({
    required this.ticketsCount,
    required this.seatName,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketInfoRow(
          'Tickets',
          ticketsCount.toString(),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        TicketInfoRow(
          'Seats',
          seatName,
        ),
      ],
    );
  }
}

class MovieTimeAndCinemaSectionView extends StatelessWidget {
  String? movieName, cinemaName, date, time;
  MovieTimeAndCinemaSectionView(
      {required this.movieName,
      required this.cinemaName,
      required this.date,
      required this.time});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          movieName ?? "",
          style: const TextStyle(
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          cinemaName ?? "",
          style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          '$date, $time',
          style: const TextStyle(
            fontSize: TEXT_REGULAR_1X,
            color: Colors.black26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
