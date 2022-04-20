import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/network/movie/movie_data_agent.dart';

import '../../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieDataAgent {
  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return Future.value(getMockMovieForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return Future.value([getMockActorForTest()]);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMovieForTest().first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(getMockMovieForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }
}
