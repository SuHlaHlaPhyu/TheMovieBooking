import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/cinema_list_for_hive_vo.dart';
import 'package:movie_booking/data/vos/cinema_vo.dart';
import 'package:movie_booking/data/vos/collection_vo.dart';
import 'package:movie_booking/data/vos/date_vo.dart';
import 'package:movie_booking/data/vos/genre_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/payment_vo.dart';
import 'package:movie_booking/data/vos/production_company_vo.dart';
import 'package:movie_booking/data/vos/production_countries_vo.dart';
import 'package:movie_booking/data/vos/seating_plan_vo.dart';
import 'package:movie_booking/data/vos/snack_vo.dart';
import 'package:movie_booking/data/vos/spoken_languages_vo.dart';
import 'package:movie_booking/data/vos/timeslot_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/main.dart';
import 'package:movie_booking/pages/welcome_page.dart';
import 'package:movie_booking/persistance/hive_constant.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  /// adapter
  Hive.registerAdapter(UserDataVOAdapter());
  Hive.registerAdapter(UserCardVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountriesVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(TimeslotVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(SeatPlanVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());
  Hive.registerAdapter(CinemaListForHiveVOAdapter());

  /// box
  await Hive.openBox<UserDataVO>(BOX_NAME_USER_DATA_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<List<CinemaVO>>(BOX_NAME_TIMESLOT_VO);
  await Hive.openBox<SeatingPlanVO>(BOX_NAME_SEAT_PLAN_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<UserCardVO>(BOX_NAME_USER_CARD_VO);
  await Hive.openBox<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);

  testWidgets("movie booking UI test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// welcome page
    expect(find.byType(WelcomePage), findsOneWidget);

    /// find text and navigate to auth page
    await tester.tap(find.text(TEST_DATA_WELCOME_NAME));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// login with email
    final emailFinder = find.byKey(const ValueKey('input.email'));
    final passwordFinder = find.byKey(const ValueKey('input.password'));
    final buttonFinder = find.byKey(const ValueKey('confirm'));
    final keyFinder = find.byKey(const ValueKey('home'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// enter text and login
    await tester.enterText(emailFinder, TEST_DATA_EMAIL);
    await tester.enterText(passwordFinder, TEST_DATA_PASSWORD);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // await tester.tap(keyFinder);
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle(const Duration(seconds: 8));

    /// home page
   // expect(find.text(TEST_DATA_COMING_SOON), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_NOW_SHOWING));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// detail page
    await tester.tap(find.text(TEST_DATA_GET_TICKETS));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// choose date and time
    await tester.tap(find.text(TEST_DATA_CHOOSE_DATE_TIME));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.text(TEST_DATA_NEXT));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// choose seat
    final seatOneFinder = find.byKey(const ValueKey('A-3'));
    final seatTwoFinder = find.byKey(const ValueKey('A-5'));
    final buttonSeatFinder = find.byKey(const ValueKey('buyTicket'));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(seatOneFinder);
    await tester.tap(seatTwoFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text(TEST_DATA_SEAT), findsOneWidget);
    expect(find.text(TEST_DATA_SEAT_COUNT), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(buttonSeatFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// snack and payment
    final snackOneFinder = find.byKey(const ValueKey(1));
    final snackTwoFinder = find.byKey(const ValueKey(2));
    final snackThreeFinder = find.byKey(const ValueKey(3));
    final snackTwoMinusFinder = find.byKey(const ValueKey('Smoothies'));
    final buttonSnackFinder = find.byKey(const ValueKey('pay'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// add
    await tester.tap(snackOneFinder);

    /// add + add
    await tester.tap(snackTwoFinder);
    await tester.tap(snackTwoFinder);

    /// add
    await tester.tap(snackThreeFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// subtract quantity
    await tester.tap(snackTwoMinusFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_SUBTOTAL), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_PAYMENT));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(buttonSnackFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// card list
    expect(find.text(TEST_DATA_TOTAL), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_ADD_NEW_CARD));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// new card list
    final cardNumFinder = find.byKey(const ValueKey('cardNum'));
    final cardHolderFinder = find.byKey(const ValueKey('cardHolder'));
    final expDateFinder = find.byKey(const ValueKey('expDate'));
    final cardTypeFinder = find.byKey(const ValueKey('cardType'));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.enterText(cardNumFinder, TEST_DATA_CARD_NUM);
    await tester.enterText(cardHolderFinder, TEST_DATA_CARD_HOLDER);
    await tester.enterText(expDateFinder, TEST_DATA_EXP_DATE);
    await tester.enterText(cardTypeFinder, TEST_DATA_CARD_TYPE);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.text(TEST_DATA_NEW_CARD_CONFIRM));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text(TEST_DATA_CARD_NUM), findsOneWidget);
    expect(find.text(TEST_DATA_CARD_HOLDER), findsOneWidget);
    expect(find.text(TEST_DATA_EXP_DATE), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.text(TEST_DATA_PAYMENT_CONFIRM));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// checkout page
    expect(find.text(TEST_DATA_NOW_SHOWING), findsOneWidget);
    expect(find.text(TEST_DATA_SEAT), findsOneWidget);
    expect(find.text(TEST_DATA_SEAT_COUNT), findsOneWidget);
    expect(find.text(TEST_DATA_SEAT_SYMBOL), findsOneWidget);
    expect(find.text(TEST_DATA_CHECKOUT_TOTAL), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}

/// test data that need to change
/// seat name
/// new card data
