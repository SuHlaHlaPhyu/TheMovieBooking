import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_booking/data/models/movie/movie_model.dart';
import 'package:movie_booking/data/models/movie/movie_model_impl.dart';
import 'package:movie_booking/data/vos/actor_vo.dart';
import 'package:movie_booking/data/vos/movie_vo.dart';
import 'package:movie_booking/network/api_constants.dart';
import 'package:movie_booking/pages/movie_choose_time_page.dart';
import 'package:movie_booking/resources/dimension.dart';
import 'package:movie_booking/resources/string.dart';
import 'package:movie_booking/widgets/app_text_button.dart';
import 'package:movie_booking/widgets/title_text.dart';

import 'snack_info_page.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  MovieDetailPage({required this.movieId});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieModel movieModel = MovieModelImpl();
  List<ActorVO>? casts;
  MovieVO? movieDetails;

  @override
  void initState() {
    /// reactive movie details
    movieModel.getMovieDetailsFromDatabase(widget.movieId).listen((details) {
      setState(() {
        movieDetails = details;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// reactive credit by movie
    movieModel
        .getCreditByMovieFromDatabase(widget.movieId)
        .listen((castAndCrews) {
      setState(() {
        casts = castAndCrews;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              20,
            ),
            topLeft: Radius.circular(
              20,
            ),
          ),
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                MovieDetailAppbarView(
                  () {
                    Navigator.pop(context);
                  },
                  imageUrl: movieDetails?.posterPath ?? "",
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            TitleText(movieDetails?.title ?? ""),
                            const SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            DetailRatingView(
                              releaseDate: movieDetails?.releaseDate ?? "",
                              popularity: movieDetails?.popularity ?? 0.0,
                            ),
                            const SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            GenreView(
                              genreList:
                                  movieDetails?.getGenreListAsStringList() ??
                                      [],
                            ),
                            const SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            PlotSummaryView(movieDetails?.overview ?? ""),
                            const SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            CastView(
                              castList: casts,
                            ),
                            const SizedBox(
                              height: MARGIN_XXLARGE,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_4,
                ),
                child: GestureDetector(
                  onTap: () {
                    _navigateToChooseTimePage(context, movieDetails);
                  },
                  child: AppTextButton(
                    TICKETS_BUTTON_TEXT,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _navigateToChooseTimePage(BuildContext context, MovieVO? movie) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MovieChooseTimePage(
        movie: movie,
      ),
    ),
  );
}

class CastView extends StatelessWidget {
  const CastView({
    Key? key,
    required this.castList,
  }) : super(key: key);

  final List<ActorVO>? castList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(CAST_BUTTON_TEXT),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Wrap(
          children: [
            ...castList!
                .map(
                  (cast) => CastAvatarView(cast),
                )
                .toList(),
          ],
        ),
      ],
    );
  }
}

class CastAvatarView extends StatelessWidget {
  final ActorVO cast;
  CastAvatarView(this.cast);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CircleAvatar(
          maxRadius: MARGIN_XLARGE,
          minRadius: MARGIN_XLARGE,
          backgroundImage: NetworkImage(
            "$IMAGE_BASE_URL${cast.profilePath}",
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        )
      ],
    );
  }
}

class GenreView extends StatelessWidget {
  const GenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...genreList
            .map(
              (genre) => GenreChipView(genre),
            )
            .toList(),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: Colors.transparent,
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class PlotSummaryView extends StatelessWidget {
  String overView;
  PlotSummaryView(this.overView);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(PLOT_SUMMARY_TEXT),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        DetailText(overView),
      ],
    );
  }
}

class DetailRatingView extends StatelessWidget {
  String releaseDate;
  double popularity;
  DetailRatingView({required this.releaseDate, required this.popularity});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DetailText(releaseDate),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        RatingBar.builder(
          initialRating: 3.0,
          itemSize: MARGIN_MEDIUM_3,
          itemBuilder: (
            BuildContext context,
            int index,
          ) =>
              const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            //
            //print(rating);
          },
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        DetailText(
          popularity.toString(),
        ),
      ],
    );
  }
}

class DetailText extends StatelessWidget {
  final String text;
  DetailText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        color: Colors.black,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}

class MovieDetailAppbarView extends StatelessWidget {
  String imageUrl;
  final Function onTapBack;
  MovieDetailAppbarView(this.onTapBack, {required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_SILVER_APPBAR_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: MovieDetailsAppBarImageView(imageUrl),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: Colors.white,
                    size: MOVIE_DETAIL_PLAY_BUTTON_SIZE,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => onTapBack(),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: MARGIN_XXLARGE,
                        left: MARGIN_MEDIUM_3,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: MARGIN_XLARGE,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MARGIN_LARGE,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MARGIN_LARGE),
                  topRight: Radius.circular(MARGIN_LARGE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  String imageUrl;
  MovieDetailsAppBarImageView(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
