import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMove(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  MovieVO? getMoveById(int movieId) {
    return getMovieBox().get(movieId);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  /// reactive programming
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch(); // listen to data changes and notity
  }

  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<MovieVO>> getNowPlayingMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
























/// source of true 2 nay yar phyit nay tr[from network][from db]
/// source of true 1 khr pae phyit ag setup load mhr persistence layer mhr [reactive]
/// from network ka ya tae data ko persistence hate htae
