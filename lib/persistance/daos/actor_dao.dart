import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class ActorDao {
  static final ActorDao _singleton = ActorDao._internal();

  factory ActorDao() {
    return _singleton;
  }

  ActorDao._internal();

  void saveAllMovies(List<ActorVO> actorList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

  /// reactive programming
  Stream<void> getAllActorEventStream() {
    return getActorBox().watch();
  }

  Stream<List<ActorVO>> getAllActorsStream() {
    return Stream.value(getAllActors());
  }
}
