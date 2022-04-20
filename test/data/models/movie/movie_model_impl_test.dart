import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

import '../../../mock_data/mock_data.dart';
import '../../../network/movie/movie_data_agent_impl_mock.dart';
import '../../../persistance/actor_dao_impl_mock.dart';
import '../../../persistance/movie_dao_impl_mock.dart';

void main() {
  group("Movie model test", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving now playing movies and getting now playing movies form database",
        () {
      expect(
        movieModel.getNowPlayingMoviesFromDatabase(1),
        emits([
          MovieVO(
            false,
            "/yzpCv8CCWondN7O5au1KGiqnC3A.jpg",
            [16, 10751, 35, 14],
            675353,
            "en",
            "Sonic the Hedgehog 2",
            "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
            5126.644,
            "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
            "2022-03-01",
            "The Batman",
            false,
            7.5,
            1450,
            null,
            200000000,
            null,
            "https://www.warnerbros.com/movies/wonder-woman-1984",
            null,
            null,
            null,
            165160005,
            151,
            null,
            "Released",
            "A new era of wonder begins.",
            true,
            false,
          ),
        ]),
      );
    });

    test(
        "Saving coming soon movies and getting coming soon movies form database",
        () {
      expect(
        movieModel.getComingSoonMoviesFromDatabase(1),
        emits([
          MovieVO(
            false,
            "/yzpCv8CCWondN7O5au1KGiqnC3A.jpg",
            [16, 10751, 35, 14],
            508947,
            "en",
            "Turning Red",
            "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
            5126.644,
            "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
            "2022-03-01",
            "Turning Red",
            false,
            7.5,
            1450,
            null,
            200000000,
            null,
            "https://www.warnerbros.com/movies/wonder-woman-1984",
            null,
            null,
            null,
            165160005,
            151,
            null,
            "Released",
            "A new era of wonder begins.",
            false,
            true,
          ),
        ]),
      );
    });

    test("Get Movie details from database Test", () async {
      expect(
        movieModel.getMovieDetailsFromDatabase(508947),
        emits(getMockMovieForTest().first),
      );
    });

    test("get Credit by movies Test", () {
      expect(
          movieModel.getCreditByMovieFromDatabase(1),
          emits(
            getMockActorForTest(),
          ));
    });
  });
}
