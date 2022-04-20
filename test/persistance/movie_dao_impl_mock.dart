import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/persistance/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int?, MovieVO> moviesInDatabaseMock = {};
  @override
  Stream<void> getAllMovieEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMockMovieForTest();
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    return getMockMovieForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  MovieVO? getMoveById(int movieId) {
    return moviesInDatabaseMock.values
        .toList()
        .firstWhere((element) => element.id == movieId);
  }

  @override
  Stream<MovieVO?> getMovieByIdStream(int movieId) {
    return Stream.value(getMockMovieForTest()
        .toList()
        .firstWhere((element) => element.id == movieId));
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieStream() {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    return getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList();
  }

  @override
  void saveAllMovies(List<MovieVO> movieList) {
    movieList.forEach((element) {
      moviesInDatabaseMock[element.id] = element;
    });
  }

  @override
  void saveSingleMove(MovieVO movie) {
    if (movie != null) {
      moviesInDatabaseMock[movie.id] = movie;
    }
  }
}
