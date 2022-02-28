// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_method_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentMethodListResponse _$GetPaymentMethodListResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentMethodListResponse(
      json['code'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as String?,
    );

Map<String, dynamic> _$GetPaymentMethodListResponseToJson(
        GetPaymentMethodListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
