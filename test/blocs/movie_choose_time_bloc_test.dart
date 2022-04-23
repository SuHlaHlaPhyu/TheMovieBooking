import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/movie_choose_time_bloc.dart';

import '../data/models/auth/auth_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';

void main(){
  group("movie choose time bloc", (){
    MovieChooseTimeBloc? movieChooseTimeBloc;

    setUp((){
      movieChooseTimeBloc = MovieChooseTimeBloc(AuthModelImplMock());
    });

    test("cinema list test", (){
      expect(movieChooseTimeBloc?.cinemaList.contains(getMockCinemaTimeslot().cinemaList?.first), true);
    });
  });
}