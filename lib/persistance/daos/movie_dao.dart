import 'package:movie_booking/data/vos/movie_vo.dart';

abstract class MovieDao {

  void saveAllMovies(List<MovieVO> movieList);

  void saveSingleMove(MovieVO movie);

  MovieVO? getMoveById(int movieId);

  List<MovieVO> getAllMovies();

  /// reactive programming
  Stream<void> getAllMovieEventStream();

  List<MovieVO> getComingSoonMovies();

  List<MovieVO> getNowPlayingMovies();

  Stream<List<MovieVO>> getNowPlayingMovieStream();

  Stream<List<MovieVO>> getComingSoonMoviesStream();

  Stream<MovieVO?> getMovieByIdStream(int movieId);
}
























/// source of true 2 nay yar phyit nay tr[from network][from db]
/// source of true 1 khr pae phyit ag setup load mhr persistence layer mhr [reactive]
/// from network ka ya tae data ko persistence hate htae
