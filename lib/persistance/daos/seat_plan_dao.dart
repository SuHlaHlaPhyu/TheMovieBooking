import 'package:movie_booking/data/vos/seating_plan_vo.dart';

abstract class SeatPlanDao {

  void saveAllSeatPlan(List<SeatingPlanVO> seatPlanList);

  List<SeatingPlanVO> getAllSeatPlan();

}
