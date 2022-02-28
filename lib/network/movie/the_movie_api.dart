import 'package:dio/dio.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/network/response/get_credit_by_movie_response.dart';
import 'package:movie_booking/network/response/movie_list_response.dart';
import 'package:retrofit/retrofit.dart';

import '../api_constants.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_MOVIE_URL_DIO)
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_NOW_PLAYING_MOVIES)
  Future<MovieListResponse> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_COMING_SOON_MOVIES)
  Future<MovieListResponse> getComingSoonMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET("$ENDPOINT_MOVIE_DETAIL/{movie_id}")
  Future<MovieVO?> getMovieDetails(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );

  @GET("/3/movie/{movie_id}/credits")
  Future<GetCreditByMovieResponse> getCreditByMovie(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );
}
