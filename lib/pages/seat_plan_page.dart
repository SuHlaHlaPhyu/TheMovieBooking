import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/blocs/seat_plan_bloc.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/pages/snack_info_page.dart';
import 'package:movie_booking/resources/color.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/ticket_info_row.dart';
import 'package:provider/provider.dart';

class SeatPlanPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatPlanBloc(timelsot, date),
      child: Scaffold(
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
                  movieName: movieName?.title,
                  cinemaName: cinemaName,
                  date: date,
                  time: time,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Selector<SeatPlanBloc, List<SeatingPlanVO>>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (BuildContext context, bloc) => bloc.seatPlan,
                    builder: (BuildContext context, seatPlan, Widget? child) {
                      SeatPlanBloc bloc = Provider.of(context, listen: false);
                      return MovieSeatSectionView(
                        movieSeats: seatPlan,
                        onSelected: (index) {
                          bloc.selectedMovieSeatSection(index);
                        },
                      );
                    }),
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
                Selector<SeatPlanBloc, int>(
                    selector: (BuildContext context, bloc) => bloc.totalTickets,
                    builder:
                        (BuildContext context, totalTickets, Widget? child) {
                      return Selector<SeatPlanBloc, List<String>>(
                          selector: (BuildContext context, bloc) =>
                              bloc.seatName,
                          builder:
                              (BuildContext context, seatName, Widget? child) {
                            return TicketAndSeatInfoSectionView(
                              ticketsCount: totalTickets,
                              seatName: seatName.join(","),
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          SeatPlanBloc bloc = Provider.of(context, listen: false);
          return Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
            ),
            child: GestureDetector(
              onTap: () {
                goToNextPage(context, bloc);
              },
              child: Selector<SeatPlanBloc, double>(
                  selector: (BuildContext context, bloc) => bloc.totalPrice,
                  builder: (BuildContext context, value, Widget? child) {
                    return Selector<SeatPlanBloc, List<String>>(
                        selector: (BuildContext context, bloc) => bloc.seatName,
                        builder: (BuildContext context, value, Widget? child) {
                          return AppTextButton(
                            "Buy Ticket for \$ ${bloc.totalPrice}",
                            btnColor: bloc.seatName.isEmpty
                                ? Colors.grey
                                : PRIMARY_COLOR,
                          );
                        });
                  }),
            ),
          );
        }),
      ),
    );
  }

  void goToNextPage(BuildContext context, SeatPlanBloc bloc) {
    if (bloc.seatName.isNotEmpty) {
      _navigateToSnackInfoPage(
          context,
          movieName!,
          date,
          time!,
          cinemaName!,
          cinema,
          bloc.totalPrice,
          bloc.row!,
          bloc.seatName.join(","),
          timelsot);
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
