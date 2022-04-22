import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/seat_plan_bloc.dart';

import '../data/models/movie/auth_model_impl_mock.dart';
import '../mock_data/auth_mock_data.dart';

void main(){
  group("seat plan bloc test", (){
    SeatPlanBloc? seatPlanBloc;

    setUp((){
      seatPlanBloc = SeatPlanBloc(1, "date", AuthModelImplMock());
    });

    test("seating plan test", (){
      expect(seatPlanBloc?.seatPlan.contains(getMockSeatPlan().first), true);
    });
  });
}