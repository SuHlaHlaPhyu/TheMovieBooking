import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/persistance/daos/seat_plan_dao.dart';

class SnackDaoImplMock extends SeatPlanDao{
  @override
  List<SeatingPlanVO> getAllSeatPlan() {
    // TODO: implement getAllSeatPlan
    throw UnimplementedError();
  }

  @override
  void saveAllSeatPlan(List<SeatingPlanVO> seatPlanList) {
    // TODO: implement saveAllSeatPlan
  }
  
}