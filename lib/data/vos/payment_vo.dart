import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
part 'payment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_VO, adapterName: "PaymentVOAdapter")
class PaymentVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  @HiveField(3)
  bool? isSelected = false;

  PaymentVO(
    this.id,
    this.name,
    this.description,
    this.isSelected,
  );

  factory PaymentVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);

  @override
  String toString() {
    return 'SnackVO{id: $id, name: $name,description: $description,}';
  }
}
