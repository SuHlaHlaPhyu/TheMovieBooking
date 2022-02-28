// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCardResponse _$CreateCardResponseFromJson(Map<String, dynamic> json) =>
    CreateCardResponse(
      json['code'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => UserCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as String?,
    );

Map<String, dynamic> _$CreateCardResponseToJson(CreateCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
