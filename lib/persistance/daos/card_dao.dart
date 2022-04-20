import 'package:movie_booking/data/vos/user_card_vo.dart';

abstract class UserCardDao {

  void saveAllUserCards(List<UserCardVO> cardList);

  List<UserCardVO> getAllUserCards();

  Stream<void> getUserCardEventStream();

  Stream<List<UserCardVO>> getAllUserCardsStream();
}
