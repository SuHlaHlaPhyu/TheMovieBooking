import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/home_bloc.dart';

import '../data/models/auth/auth_model_impl_mock.dart';
import '../data/models/movie/movie_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';
import '../mock_data/movie_mock_data.dart';

void main(){
  group("home bloc test", (){
    HomeBloc? homeBloc;

    setUp((){
      homeBloc = HomeBloc(MovieModelImplMock(),AuthModelImplMock());
    });

    test("fetch now showing movies", (){
      expect(homeBloc?.nowShowingMovies?.contains(getMockMovieTest().first), true);
    });

    test("fetch coming soon movies", (){
      expect(homeBloc?.comingSoonMovies?.contains(getMockMovieTest()[1]), true);
    });

    test("fetch user data", (){
      expect(homeBloc?.userData, getUserDataMockTest());
    });
  });
}