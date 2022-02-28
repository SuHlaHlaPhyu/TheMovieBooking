import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';

part 'get_credit_by_movie_response.g.dart';

@JsonSerializable()
class GetCreditByMovieResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "cast")
  List<ActorVO>? cast;

  @JsonKey(name: "crew")
  List<ActorVO>? crew;


  GetCreditByMovieResponse(this.id, this.cast, this.crew);

  factory GetCreditByMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCreditByMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditByMovieResponseToJson(this);
}
