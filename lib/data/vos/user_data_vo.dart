import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';
part 'user_data_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_USER_DATA_VO, adapterName: "UserDataVOAdapter")
class UserDataVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "email")
  @HiveField(2)
  String? email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;

  @JsonKey(name: "cards")
  @HiveField(6)
  List<UserCardVO>? cards;

  @HiveField(7)
  String? userToken;

  UserDataVO(this.id, this.cards, this.email, this.name, this.phone,
      this.profileImage, this.totalExpense,this.userToken);

  factory UserDataVO.fromJson(Map<String, dynamic> json) =>
      _$UserDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataVOToJson(this);

  @override
  String toString() {
    return 'UserDataVO{id: $id, name: $name, email: $email, phone: $phone, total_expense: $totalExpense, profile_image: $profileImage, cards: $cards,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
