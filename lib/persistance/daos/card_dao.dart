import 'package:hive/hive.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

class UserCardDao {
  static final UserCardDao _singleton = UserCardDao._internal();

  factory UserCardDao() {
    return _singleton;
  }

  UserCardDao._internal();

  void saveAllUserCards(List<UserCardVO> cardList) async {
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<int, UserCardVO> cardMap = Map.fromIterable(cardList,
        key: (card) => card.id, value: (card) => card);
    await getUserCardsBox().putAll(cardMap);
  }

  List<UserCardVO> getAllUserCards() {
    return getUserCardsBox().values.toList();
  }

  Box<UserCardVO> getUserCardsBox() {
    return Hive.box<UserCardVO>(BOX_NAME_USER_CARD_VO);
  }
}
