import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/persistance/daos/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDao{

  Map<int?, ActorVO> actorInDatabaseMock = {};
  @override
  Stream<void> getAllActorEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<ActorVO> getAllActors() {
    return actorInDatabaseMock.values.toList();
  }

  @override
  Stream<List<ActorVO>> getAllActorsStream() {
   return Stream.value(getMockActorForTest());
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    actorList.forEach((actor) {
      actorInDatabaseMock[actor.id] = actor;
    });
  }
  
}