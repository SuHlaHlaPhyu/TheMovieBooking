// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentVOAdapter extends TypeAdapter<PaymentVO> {
  @override
  final int typeId = 15;

  @override
  PaymentVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVO _$PaymentVOFromJson(Map<String, dynamic> json) => PaymentVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$PaymentVOToJson(PaymentVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
