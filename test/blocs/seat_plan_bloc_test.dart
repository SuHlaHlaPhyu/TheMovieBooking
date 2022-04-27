import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/blocs/seat_plan_bloc.dart';
import '../data/models/auth/auth_model_impl_mock.dart';
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

    test("selected seat name test", () async{
      seatPlanBloc?.selectedMovieSeatSection(0);
      await Future.delayed(const Duration(seconds: 3));
      expect(seatPlanBloc?.seatName, ["A-4"]);
    });

    test("selected row name test", () async{
      seatPlanBloc?.selectedMovieSeatSection(0);
      await Future.delayed(const Duration(seconds: 3));
      expect(seatPlanBloc?.row, "A");
    });

    test("total price test", () async{
      seatPlanBloc?.selectedMovieSeatSection(0);
      await Future.delayed(const Duration(seconds: 3));
      expect(seatPlanBloc?.totalPrice, 2);
    });

    test("total ticket test", () async{
      seatPlanBloc?.selectedMovieSeatSection(0);
      await Future.delayed(const Duration(seconds: 3));
      expect(seatPlanBloc?.totalTickets, 1);
    });

    // test("selected seat name test", () async{
    //   seatPlanBloc?.onTapMovieSeatSection(SeatingPlanVO(1, "available", 0, "A-4", "A", false),);
    //   await Future.delayed(const Duration(seconds: 3));
    //   expect(seatPlanBloc?.seatName, ["A-4"]);
    // });
    // test("selected row name test", () async{
    //   seatPlanBloc?.onTapMovieSeatSection(SeatingPlanVO(1, "available", 0, "A-4", "A", false),);
    //   await Future.delayed(const Duration(seconds: 3));
    //   expect(seatPlanBloc?.row, "A");
    // });
  });
}