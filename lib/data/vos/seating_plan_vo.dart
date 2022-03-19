import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
import 'package:movie_booking/resources/string.dart';
part 'seating_plan_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SEAT_PLAN_VO, adapterName: "SeatPlanVOAdapter")
class SeatingPlanVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "type")
  @HiveField(1)
  String? type;

  @JsonKey(name: "seat_name")
  @HiveField(2)
  String? seatName;

  @JsonKey(name: "symbol")
  @HiveField(3)
  String? symbol;

  @JsonKey(name: "price")
  @HiveField(4)
  double? price;

  @HiveField(5)
  bool? isSelected = false;

  SeatingPlanVO(this.id, this.type, this.price, this.seatName, this.symbol,
      this.isSelected);

  factory SeatingPlanVO.fromJson(Map<String, dynamic> json) =>
      _$SeatingPlanVOFromJson(json);

  Map<String, dynamic> toJson() => _$SeatingPlanVOToJson(this);

  bool isMovieSeatAvailable() {
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken() {
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle() {
    return type == SEAT_TYPE_TEXT;
  }

  @override
  String toString() {
    return 'SeatingPlanVO{id: $id, type: $type,seatName: $id, symbol: $symbol,price: $price, isSelected : $isSelected}';
  }

  @override
  int get hashCode => isSelected.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SeatingPlanVO && isSelected == other.isSelected;
}
