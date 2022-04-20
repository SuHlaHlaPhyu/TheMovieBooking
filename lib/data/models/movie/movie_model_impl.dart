import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/network/movie/movie_data_agent.dart';
import 'package:movie_booking/network/movie/retrofit_data_agent_impl.dart';
import 'package:movie_booking/persistance/daos/actor_dao.dart';
import 'package:movie_booking/persistance/daos/impl/actor_dao_impl.dart';
import 'package:movie_booking/persistance/daos/impl/movie_dao_impl.dart';
import 'package:movie_booking/persistance/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();
  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();
  MovieDao movieDao = MovieDaoImpl();
  ActorDao actorDao = ActorDaoImpl();

  /// for testing purpose
  void setDaosAndDataAgents(
      MovieDao movieDaoTest,
      ActorDao actorDaoTest,
      MovieDataAgent movieDataAgentTest,
      ) {
    movieDao = movieDaoTest;
    actorDao = actorDaoTest;
    dataAgent = movieDataAgentTest;
  }

  /// from network

  /// Stream
  @override
  void getComingSoonMovies(int page) {
    dataAgent.getComingSoonMovies(page).then((movies) async {
      List<MovieVO> comingSoonMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isComingSoon = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(comingSoonMovies);
    });
  }

  @override
  void getNowPlayingMovies(int page) {
    dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isComingSoon = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
    });
  }

  @override
  void getMovieDetails(int movieId) {
    dataAgent.getMovieDetails(movieId).then((movie) {
      movieDao.saveSingleMove(movie!);
    });
  }

  @override
  void getCreditByMovie(int movieId) {
    dataAgent.getCreditByMovie(movieId).then((value) {
      List<ActorVO>? actorList = value.first;
      actorDao.saveAllActors(actorList!);
    });
  }

  /// from database
  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase(int page) {
    getComingSoonMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getComingSoonMoviesStream())
        .map((event) => movieDao.getComingSoonMovies());
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page) {
    getNowPlayingMovies(1);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getNowPlayingMovieStream())
        .map((event) => movieDao.getNowPlayingMovies());
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    getMovieDetails(movieId);
    return movieDao
        .getAllMovieEventStream()
        // ignore: void_checks
        .startWith(movieDao.getMovieByIdStream(movieId))
        .map((event) => movieDao.getMoveById(movieId));
  }

  @override
  Stream<List<ActorVO>?> getCreditByMovieFromDatabase(int movieId) {
    getCreditByMovie(movieId);
    return actorDao
        .getAllActorEventStream()
        // ignore: void_checks
        .startWith(actorDao.getAllActorsStream())
        .map((event) => actorDao.getAllActors());
  }
}


/// combineLatest
/// combineLatest [stream List<MovieVo> phyit nay ml, future pyan paung pho' [.first] ko call pay ya tl]
/// combine 2 stream to 1 stream
/// need 2 parameter (1st stream, stream 2 khu bl myo paung ma ll ===> [ thu mhr parameter 2 khu htet shi])
/// 1st is used to know changes in box [get from 1st stream]
/// 2nd is real data that used in widget [get from 2nd stream]