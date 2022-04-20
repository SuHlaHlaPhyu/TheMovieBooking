import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/persistance/daos/movie_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class MovieDaoImpl extends MovieDao{
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveAllMovies(List<MovieVO> movieList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMove(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  @override
  MovieVO? getMoveById(int movieId) {
    return getMovieBox().get(movieId);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  /// reactive programming
  @override
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch(); // listen to data changes and notity
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Stream<MovieVO?> getMovieByIdStream(int movieId) {
    return Stream.value(getMoveById(movieId));
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
