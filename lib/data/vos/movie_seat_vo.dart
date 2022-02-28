import 'package:movie_booking/resources/string.dart';

class MovieSeatVO {
  String title;
  String type;
  MovieSeatVO({
    required this.title,
    required this.type,
  });

  bool isMovieSeatAvailable() {
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken() {
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle() {
    return type == SEAT_TYPE_TEXT;
  }
}
