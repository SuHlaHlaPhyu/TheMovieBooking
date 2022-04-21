import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/persistance/daos/seat_plan_dao.dart';

import '../mock_data/auth_mock_data.dart';

class SeatPlanDaoImplMock extends SeatPlanDao{
  Map< int , SeatingPlanVO> seatPlanInMockDatabase = {};
  @override
  List<SeatingPlanVO> getAllSeatPlan() {
    return getMockSeatPlan();
  }

  @override
  void saveAllSeatPlan(List<SeatingPlanVO> seatPlanList) {
   seatPlanList.forEach((element) {
     seatPlanInMockDatabase [element.id ?? 0] = element;
   });
  }
  
}