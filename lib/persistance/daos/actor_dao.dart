import 'package:movie_booking/data/vos/actor_vo.dart';

abstract class ActorDao {

  void saveAllActors(List<ActorVO> actorList);

  List<ActorVO> getAllActors();

  Stream<void> getAllActorEventStream();

  Stream<List<ActorVO>> getAllActorsStream();
}
