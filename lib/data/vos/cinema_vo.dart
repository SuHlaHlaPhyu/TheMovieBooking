import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/data/vos/timeslot_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO, adapterName: "CinemaVOAdapter")
class CinemaVO {
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeslotVO>? timeslots;

  @HiveField(3)
  List<String>? dates;

  CinemaVO(this.cinemaId, this.cinema, this.timeslots, this.dates);

  factory CinemaVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);

  @override
  String toString() {
    return 'CinemaVO{cinema_id: $cinemaId, cinema: $cinema, timeslots: $timeslots, dates:$dates}';
  }
}
