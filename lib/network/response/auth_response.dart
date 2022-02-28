import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserDataVO? data;

  @JsonKey(name: "token")
  String? token;

  AuthResponse(this.code, this.data, this.message, this.token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
