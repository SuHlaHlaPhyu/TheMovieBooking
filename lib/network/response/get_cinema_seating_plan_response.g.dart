// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_seating_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaSeatingPlanResponse _$GetCinemaSeatingPlanResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaSeatingPlanResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SeatingPlanVO.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$GetCinemaSeatingPlanResponseToJson(
        GetCinemaSeatingPlanResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
