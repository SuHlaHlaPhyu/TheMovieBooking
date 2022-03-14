import 'package:flutter/foundation.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';

import '../data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// States
  List<MovieVO>? nowShowingMovies;
  List<MovieVO>? comingSoonMovies;

  /// Model
  MovieModel movieModel = MovieModelImpl();

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
  }
}
