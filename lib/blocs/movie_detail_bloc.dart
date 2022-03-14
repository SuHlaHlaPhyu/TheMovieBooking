import 'package:flutter/foundation.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailBloc extends ChangeNotifier {
  /// States
  List<ActorVO>? casts;
  MovieVO? movieDetails;

  /// model
  MovieModel movieModel = MovieModelImpl();

  MovieDetailBloc(int movieId) {
    /// movie details
    movieModel.getMovieDetailsFromDatabase(movieId).listen((movie) {
      movieDetails = movie;
      notifyListeners();
    }).onError((error) {});

    /// casts
    movieModel.getCreditByMovieFromDatabase(movieId).listen((castList) {
      casts = castList;
      notifyListeners();
    }).onError((error) {});
  }
}
