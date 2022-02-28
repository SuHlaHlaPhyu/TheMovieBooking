import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

abstract class MovieDataAgent {
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getComingSoonMovies(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId);
}
