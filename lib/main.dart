import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/data/vos/user_card_vo.dart';
import 'package:movie_booking/data/vos/user_data_vo.dart';
import 'package:movie_booking/pages/welcome_page.dart';
import 'data/vos/cinema_list_for_hive_vo.dart';
import 'data/vos/cinema_vo.dart';
import 'data/vos/timeslot_vo.dart';
import 'data/vos/collection_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_countries_vo.dart';
import 'data/vos/spoken_languages_vo.dart';
import 'data/vos/user_data_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/actor_vo.dart';
import 'data/vos/seating_plan_vo.dart';
import 'data/vos/snack_vo.dart';
import 'data/vos/payment_vo.dart';
import 'persistance/hive_constant.dart';

void main() async {
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      home: WelcomePage(),
    );
  }
}

// fvm flutter packages run build_runner build
// fvm flutter packages run build_runner build --delete-conflicting-outputs
