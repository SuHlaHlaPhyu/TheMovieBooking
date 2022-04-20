import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/persistance/daos/actor_dao.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class ActorDaoImpl extends ActorDao{
  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() {
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  void saveAllActors(List<ActorVO> actorList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

  /// reactive programming
  @override
  Stream<void> getAllActorEventStream() {
    return getActorBox().watch();
  }

  @override
  Stream<List<ActorVO>> getAllActorsStream() {
    return Stream.value(getAllActors());
  }
}
