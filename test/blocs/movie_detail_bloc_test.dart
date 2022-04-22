import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/movie_detail_bloc.dart';

import '../data/models/movie/movie_model_impl_mock.dart';
import '../mock_data/movie_mock_data.dart';

void main(){
  group("movie details bloc", (){
    MovieDetailBloc? movieDetailBloc;

    setUp((){
      movieDetailBloc = MovieDetailBloc(1, MovieModelImplMock());
    });

    test("movie details test", (){
      expect(movieDetailBloc?.movieDetails, getMockMovieTest().first);
    });

    test("credit by movie test", (){
      expect(movieDetailBloc?.casts?.contains(getMockActorForTest().first), true);
    });
  });
}