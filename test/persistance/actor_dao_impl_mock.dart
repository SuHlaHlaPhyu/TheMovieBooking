import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/persistance/daos/actor_dao.dart';

class ActorDaoImplMock extends ActorDao{
  @override
  Stream<void> getAllActorEventStream() {
    // TODO: implement getAllActorEventStream
    throw UnimplementedError();
  }

  @override
  List<ActorVO> getAllActors() {
    // TODO: implement getAllActors
    throw UnimplementedError();
  }

  @override
  Stream<List<ActorVO>> getAllActorsStream() {
    // TODO: implement getAllActorsStream
    throw UnimplementedError();
  }

  @override
  void saveAllMovies(List<ActorVO> actorList) {
    // TODO: implement saveAllMovies
  }
  
}