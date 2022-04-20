import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

import '../card_dao.dart';

class UserCardDaoImpl extends UserCardDao {
  static final UserCardDaoImpl _singleton = UserCardDaoImpl._internal();

  factory UserCardDaoImpl() {
    return _singleton;
  }

  UserCardDaoImpl._internal();

  @override
  void saveAllUserCards(List<UserCardVO> cardList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, UserCardVO> cardMap = Map.fromIterable(cardList,
        key: (card) => card.id, value: (card) => card);
    await getUserCardsBox().putAll(cardMap);
  }

  @override
  List<UserCardVO> getAllUserCards() {
    return getUserCardsBox().values.toList();
  }

  Box<UserCardVO> getUserCardsBox() {
    return Hive.box<UserCardVO>(BOX_NAME_USER_CARD_VO);
  }

  /// reactive programming
  @override
  Stream<void> getUserCardEventStream() {
    return getUserCardsBox().watch();
  }

  @override
  Stream<List<UserCardVO>> getAllUserCardsStream() {
    return Stream.value(getAllUserCards());
  }
}
