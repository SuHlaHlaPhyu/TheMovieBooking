import 'package:flutter/foundation.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';

import '../data/models/auth/auth_model.dart';
import '../data/models/auth/auth_model_impl.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/user_data_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// States
  List<MovieVO>? nowShowingMovies;
  List<MovieVO>? comingSoonMovies;
  UserDataVO? userData;

  /// Model
  MovieModel movieModel = MovieModelImpl();
  AuthModel authModel = AuthModelImpl();

  HomeBloc() {
    /// Now playing movies
    movieModel.getNowPlayingMoviesFromDatabase(1).listen((movieList) {
      nowShowingMovies = movieList;
      notifyListeners();
    }).onError((error) {});

    /// Coming soon movies
    movieModel.getComingSoonMoviesFromDatabase(1).listen((movieList) {
      comingSoonMovies = movieList;
      notifyListeners();
    }).onError((erorr) {});

    authModel.getUserDatafromDatabase().listen((user) {
      userData = user;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }
}
