import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/persistance/daos/card_dao.dart';

class CardDaoImplMock extends UserCardDao{
  @override
  List<UserCardVO> getAllUserCards() {
    // TODO: implement getAllUserCards
    throw UnimplementedError();
  }

  @override
  Stream<List<UserCardVO>> getAllUserCardsStream() {
    // TODO: implement getAllUserCardsStream
    throw UnimplementedError();
  }

  @override
  Stream<void> getUserCardEventStream() {
    // TODO: implement getUserCardEventStream
    throw UnimplementedError();
  }

  @override
  void saveAllUserCards(List<UserCardVO> cardList) {
    // TODO: implement saveAllUserCards
  }
  
}