// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCardVOAdapter extends TypeAdapter<UserCardVO> {
  @override
  final int typeId = 2;

  @override
  UserCardVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCardVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[4] as String?,
      fields[3] as String?,
      fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserCardVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardHolder)
      ..writeByte(2)
      ..write(obj.cardNumber)
      ..writeByte(3)
      ..write(obj.expirationDate)
      ..writeByte(4)
      ..write(obj.cardType)
      ..writeByte(5)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCardVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCardVO _$UserCardVOFromJson(Map<String, dynamic> json) => UserCardVO(
      json['id'] as int?,
      json['card_holder'] as String?,
      json['card_number'] as String?,
      json['card_type'] as String?,
      json['expiration_date'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$UserCardVOToJson(UserCardVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_holder': instance.cardHolder,
      'card_number': instance.cardNumber,
      'expiration_date': instance.expirationDate,
      'card_type': instance.cardType,
      'isSelected': instance.isSelected,
    };
