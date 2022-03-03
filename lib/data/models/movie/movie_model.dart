import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

abstract class MovieModel {
  /// network
  // Future<MovieVO?> getMovieDetails(int movieId);
  //Future<List<List<ActorVO>?>> getCreditByMovie(int movieId);

  /// database
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page);
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase(int page);
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);
  Stream<List<ActorVO>?> getCreditByMovieFromDatabase(int movieId);

  /// stream
  void getNowPlayingMovies(int page);
  void getComingSoonMovies(int page);
  void getMovieDetails(int movieId);
  void getCreditByMovie(int movieId);
}
