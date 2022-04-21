import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_VO, adapterName: "SnackVOAdapter")
class SnackVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  @JsonKey(name: "price")
  @HiveField(3)
  double? price;

  @JsonKey(name: "image")
  @HiveField(4)
  String? image;

  @HiveField(5)
  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "unit_price")
  @HiveField(6)
  int? unitPrice;

  @JsonKey(name: "total_price")
  @HiveField(7)
  int? totalPrice;

  SnackVO(this.id, this.name, this.price, this.description, this.image,
      this.quantity,this.totalPrice,this.unitPrice);

  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackVOToJson(this);

  @override
  String toString() {
    return 'SnackVO{id: $id, name: $name,description: $description, price: $price,image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
