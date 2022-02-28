// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataVOAdapter extends TypeAdapter<UserDataVO> {
  @override
  final int typeId = 1;

  @override
  UserDataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataVO(
      fields[0] as int?,
      (fields[6] as List?)?.cast<UserCardVO>(),
      fields[2] as String?,
      fields[1] as String?,
      fields[3] as String?,
      fields[5] as String?,
      fields[4] as int?,
      fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.totalExpense)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.cards)
      ..writeByte(7)
      ..write(obj.userToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataVO _$UserDataVOFromJson(Map<String, dynamic> json) => UserDataVO(
      json['id'] as int?,
      (json['cards'] as List<dynamic>?)
          ?.map((e) => UserCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['email'] as String?,
      json['name'] as String?,
      json['phone'] as String?,
      json['profile_image'] as String?,
      json['total_expense'] as int?,
      json['userToken'] as String?,
    );

Map<String, dynamic> _$UserDataVOToJson(UserDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
      'cards': instance.cards,
      'userToken': instance.userToken,
    };
