import 'package:dio/dio.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/network/movie/the_movie_api.dart';

import '../api_constants.dart';
import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mapi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mapi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mapi
        .getNowPlayingMovies(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return mapi
        .getComingSoonMovies(
          API_KEY,
          LANGUAGE_EN_US,
          page.toString(),
        )
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return mapi
        .getCreditByMovie(
          movieId.toString(),
          API_KEY,
        )
        .asStream()
        .map((getCreditsByMovieResponse) =>
            [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew])
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mapi.getMovieDetails(
      movieId.toString(),
      API_KEY,
    );
  }
}
