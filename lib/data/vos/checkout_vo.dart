import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/timeslot_vo.dart';

part 'checkout_vo.g.dart';

@JsonSerializable()
class CheckoutVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "booking_no")
  String? bookingNo;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "row")
  String? row;

  @JsonKey(name: "seat")
  String? seat;

  @JsonKey(name: "total_seat")
  int? totalSeat;

  @JsonKey(name: "total")
  String? total;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "username")
  String? username;

  @JsonKey(name: "timeslot")
  TimeslotVO? timeslot;

  @JsonKey(name: "snacks")
  List<SnackVO>? snacks;

  @JsonKey(name: "qr_code")
  String? qrCode;

  CheckoutVO(
    this.bookingDate,
    this.bookingNo,
    this.cinemaId,
    this.id,
    this.movieId,
    this.qrCode,
    this.row,
    this.seat,
    this.snacks,
    this.timeslot,
    this.total,
    this.totalSeat,
    this.username,
  );

  factory CheckoutVO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutVOToJson(this);

  @override
  String toString() {
    return 'CheckoutVO{id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, username: $username, timeslot: $timeslot, snacks: $snacks, qrCode: $qrCode}';
  }
}
