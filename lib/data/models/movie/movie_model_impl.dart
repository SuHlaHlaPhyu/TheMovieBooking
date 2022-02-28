import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/network/movie/movie_data_agent.dart';
import 'package:movie_booking/network/movie/retrofit_data_agent_impl.dart';
import 'package:movie_booking/persistance/daos/actor_dao.dart';
import 'package:movie_booking/persistance/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  final MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();
  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();
  MovieDao movieDao = MovieDao();
  ActorDao actorDao = ActorDao();

  // from network
  // @override
  // Future<List<MovieVO>> getComingSoonMovies(int page) {
  //   return _dataAgent.getComingSoonMovies(page).then((movies) async {
  //     List<MovieVO> comingSoonMovies = movies!.map((movie) {
  //       movie.isNowPlaying = false;
  //       movie.isComingSoon = true;
  //       return movie;
  //     }).toList();
  //     movieDao.saveAllMovies(comingSoonMovies);
  //     return Future.value(movies);
  //   });
  // }
  // @override
  // Future<List<MovieVO>> getNowPlayingMovies(int page) {
  //   return _dataAgent.getNowPlayingMovies(page).then((movies) async {
  //     List<MovieVO> nowPlayingMovies = movies!.map((movie) {
  //       movie.isNowPlaying = true;
  //       movie.isComingSoon = false;
  //       return movie;
  //     }).toList();
  //     movieDao.saveAllMovies(nowPlayingMovies);
  //     return Future.value(movies);
  //   });
  // }

  @override
  Future<List<List<ActorVO>?>> getCreditByMovie(int movieId) {
    return _dataAgent.getCreditByMovie(movieId).then((value) {
      List<ActorVO>? actorList = value.first;
      actorDao.saveAllMovies(actorList!);
      return Future.value(value);
    });
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) {
      movieDao.saveSingleMove(movie!);
      return Future.value(movie);
    });
  }

  /// from database
  // @override
  // Future<List<MovieVO>?> getComingSoonMoviesFromDatabase(int page) {
  //   return Future.value(movieDao
  //       .getAllMovies()
  //       .where((movie) => movie.isComingSoon ?? true)
  //       .toList());
  // }
  // @override
  // Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page) {
  //   return Future.value(movieDao
  //       .getAllMovies()
  //       .where((movie) => movie.isNowPlaying ?? true)
  //       .toList());
  // }

  @override
  Future<List<ActorVO>?> getCreditByMovieFromDatabase(int movieId) {
    return Future.value(actorDao.getAllActors().toList());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getMoveById(movieId));
  }

  /// Stream
  @override
  void getComingSoonMovies(int page) {
    _dataAgent.getComingSoonMovies(page).then((movies) async {
      List<MovieVO> comingSoonMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isComingSoon = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(comingSoonMovies);
      print("coming soon save successfully");
    });
  }

  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isComingSoon = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      print("coming soon save successfully");
    });
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase(int page) {
    getComingSoonMovies(1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getComingSoonMoviesStream())
        .map((event) => movieDao.getComingSoonMovies());
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page) {
    getNowPlayingMovies(1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getComingSoonMovies());
  }
}


/// combineLatest
/// combineLatest [stream List<MovieVo> phyit nay ml, future pyan paung pho' [.first] ko call pay ya tl]
/// combine 2 stream to 1 stream
/// need 2 parameter (1st stream, stream 2 khu bl myo paung ma ll ===> [ thu mhr parameter 2 khu htet shi])
/// 1st is used to know changes in box [get from 1st stream]
/// 2nd is real data that used in widget [get from 2nd stream]