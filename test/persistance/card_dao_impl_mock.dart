import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/persistance/daos/card_dao.dart';

import '../mock_data/auth_mock_data.dart';

class CardDaoImplMock extends UserCardDao{
  Map<int , UserCardVO> userCardInMockDatabase = {};
  @override
  List<UserCardVO> getAllUserCards() {
    return getMockUserCard();
  }

  @override
  Stream<List<UserCardVO>> getAllUserCardsStream() {
    return Stream.value(getMockUserCard());
  }

  @override
  Stream<void> getUserCardEventStream() {
    return Stream.value(null);
  }

  @override
  void saveAllUserCards(List<UserCardVO> cardList) {
    cardList.forEach((element) {
      userCardInMockDatabase[element.id ?? 0] = element;
    });
  }
  
}