import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class SeatPlanDao {
  static final SeatPlanDao _singleton = SeatPlanDao._internal();

  factory SeatPlanDao() {
    return _singleton;
  }

  SeatPlanDao._internal();

  void saveAllSeatPlan(List<SeatingPlanVO> seatPlanList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, SeatingPlanVO> seatPlanMap = Map.fromIterable(seatPlanList,
        key: (seat) => seat.id, value: (seat) => seat);
    await getSeatPlanBox().putAll(seatPlanMap);
  }

  List<SeatingPlanVO> getAllSeatPlan() {
    return getSeatPlanBox().values.toList();
  }

  Box<SeatingPlanVO> getSeatPlanBox() {
    return Hive.box<SeatingPlanVO>(BOX_NAME_SEAT_PLAN_VO);
  }
}
