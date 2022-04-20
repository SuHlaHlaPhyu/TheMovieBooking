import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

import '../../../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel {
  @override
  void getComingSoonMovies(int page) {
    // no need to mock
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase(int page) {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  void getCreditByMovie(int movieId) {
    // no need to mock
  }

  @override
  Stream<List<ActorVO>?> getCreditByMovieFromDatabase(int movieId) {
    return Stream.value(getMockActorForTest());
  }

  @override
  void getMovieDetails(int movieId) {
    // no need to mock
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Stream.value(getMockMovieForTest().first);
  }

  @override
  void getNowPlayingMovies(int page) {
    // no need to mock
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page) {
    return Stream.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }
}
