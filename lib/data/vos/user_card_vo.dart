import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
part 'user_card_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_USER_CARD_VO, adapterName: "UserCardVOAdapter")
class UserCardVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "card_holder")
  @HiveField(1)
  String? cardHolder;

  @JsonKey(name: "card_number")
  @HiveField(2)
  String? cardNumber;

  @JsonKey(name: "expiration_date")
  @HiveField(3)
  String? expirationDate;

  @JsonKey(name: "card_type")
  @HiveField(4)
  String? cardType;

  UserCardVO(this.id, this.cardHolder, this.cardNumber, this.cardType,
      this.expirationDate);

  factory UserCardVO.fromJson(Map<String, dynamic> json) =>
      _$UserCardVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserCardVOToJson(this);

  @override
  String toString() {
    return 'UserCardVO{id: $id, card_holder: $cardHolder, card_number: $cardNumber, expiration_date: $expirationDate, card_type: $cardType,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCardVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardHolder == other.cardHolder;

  @override
  int get hashCode => id.hashCode ^ cardHolder.hashCode;
}

/// difference between importing hive and importing hive_flutter
/// with hive_flutter, can't register Adapter in main.dart. hive cannot detected Adapter
/// but with hive, it solved.
