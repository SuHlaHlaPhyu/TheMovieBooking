import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';

import '../../../mock_data/movie_mock_data.dart';
import '../../../network/movie/movie_data_agent_impl_mock.dart';
import '../../../persistance/actor_dao_impl_mock.dart';
import '../../../persistance/movie_dao_impl_mock.dart';

void main() {
  group(
    "Movie model test",
    () {
      var movieModel = MovieModelImpl();

      setUp(
        () {
          movieModel.setDaosAndDataAgents(
            MovieDaoImplMock(),
            ActorDaoImplMock(),
            MovieDataAgentImplMock(),
          );
        },
      );

      test(
        "Saving now playing movies and getting now playing movies form database",
        () {
          expect(
            movieModel.getNowPlayingMoviesFromDatabase(1),
            emits(
              [
            MovieVO(
            null,
            null,
            [],
            1,
            "Myan",
            "test",
            "overview",
            null,
            null,
            "releaseDate",
            "test one",
            null,
            1.2,
            5,
            null,
            0,
            null,
            "homepage",
            "imdbId",
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            true,
            false,
            ),
              ],
            ),
          );
        },
      );

      test(
        "Saving coming soon movies and getting coming soon movies form database",
        () {
          expect(
            movieModel.getComingSoonMoviesFromDatabase(1),
            emits(
              [
                MovieVO(
                  null,
                  null,
                  [],
                  2,
                  "Myan",
                  "test",
                  "overview",
                  null,
                  null,
                  "releaseDate",
                  "test two",
                  null,
                  1.2,
                  5,
                  null,
                  0,
                  null,
                  "homepage",
                  "imdbId",
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  false,
                  true,
                ),
              ],
            ),
          );
        },
      );

      test(
        "Get Movie details from database Test",
        () async {
          expect(
            movieModel.getMovieDetailsFromDatabase(508947),
            emits(getMockMovieTest().first),
          );
        },
      );

      test(
        "get Credit by movies Test",
        () {
          expect(
            movieModel.getCreditByMovieFromDatabase(1),
            emits(
              getMockActorForTest(),
            ),
          );
        },
      );
    },
  );
}
