// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutVO _$CheckoutVOFromJson(Map<String, dynamic> json) => CheckoutVO(
      json['booking_date'] as String?,
      json['booking_no'] as String?,
      json['cinema_id'] as int?,
      json['id'] as int?,
      json['movie_id'] as int?,
      json['qr_code'] as String?,
      json['row'] as String?,
      json['seat'] as String?,
      (json['snacks'] as List<dynamic>?)
          ?.map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['timeslot'] == null
          ? null
          : TimeslotVO.fromJson(json['timeslot'] as Map<String, dynamic>),
      json['total'] as String?,
      json['total_seat'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$CheckoutVOToJson(CheckoutVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'booking_date': instance.bookingDate,
      'row': instance.row,
      'seat': instance.seat,
      'total_seat': instance.totalSeat,
      'total': instance.total,
      'movie_id': instance.movieId,
      'cinema_id': instance.cinemaId,
      'username': instance.username,
      'timeslot': instance.timeslot,
      'snacks': instance.snacks,
      'qr_code': instance.qrCode,
    };
