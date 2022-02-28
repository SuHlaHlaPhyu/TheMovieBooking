import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/network/snack_request.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckOutRequest {
  @JsonKey(name: "cinema_day_timeslot_id")
  int cinemaDayTimeSlotId;
  @JsonKey(name: "row")
  String row;
  @JsonKey(name: "seat_number")
  String seatNumber;
  @JsonKey(name: "booking_date")
  String bookingDate;
  @JsonKey(name: "total_price")
  double totalPrice;
  @JsonKey(name: "movie_id")
  int movieId;
  @JsonKey(name: "card_id")
  int cardId;
  @JsonKey(name: "cinema_id")
  int cinemaId;
  @JsonKey(name: "snacks")
  List<SnackRequest> snacks;
  CheckOutRequest(
      this.cinemaDayTimeSlotId,
      this.seatNumber,
      this.bookingDate,
      this.movieId,
      this.cardId,
      this.snacks,
      this.cinemaId,
      this.row,
      this.totalPrice);
  factory CheckOutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);

  @override
  String toString() {
    return 'CheckOutRequest{cinema_day_timeslot_id: $cinemaDayTimeSlotId, row: $row, seat_number: $seatNumber,booking_date: $bookingDate,total_price: $totalPrice,movie_id: $movieId,card_id: $cardId,cinema_id: $cinemaId,snacks: $snacks}';
  }
}
