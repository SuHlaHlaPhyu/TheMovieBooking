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

    test("selected date", () async{
      movieChooseTimeBloc?.getTimeSlotbyDate("22-4-2022");
      await Future.value(const Duration(seconds: 5));
      expect(movieChooseTimeBloc?.selectedDate, "22-4-2022");
    });

    test("selected cinema", () async{
      movieChooseTimeBloc?.chooseItemGrid(0,0);
      await Future.value(const Duration(seconds: 5));
      expect(movieChooseTimeBloc?.selectedCinema, "Cinema I");
    });

    test("selected movie time", () async{
      movieChooseTimeBloc?.chooseItemGrid(0,0);
      await Future.value(const Duration(seconds: 5));
      expect(movieChooseTimeBloc?.selectedMovieTime, "10:00 AM");
    });
  });
}