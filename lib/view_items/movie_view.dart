import 'package:flutter/material.dart';

import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimension.dart';
import '../widgets/sub_text.dart';

class MovieView extends StatelessWidget {
  final MovieVO? movie;
  final Function onTapMovie;
  MovieView({
    required this.movie,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTapMovie(),
          child: Container(
            margin: const EdgeInsets.only(
              right: MARGIN_MEDIUM,
            ),
            height: HOME_SCREEN_MOVIE_HEIGHT,
            width: HOME_SCREEN_MOVIE_WIDTH,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                MARGIN_MEDIUM,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  "$IMAGE_BASE_URL${movie?.posterPath}",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Container(
          width: HOME_SCREEN_MOVIE_WIDTH,
          child: Center(
            child: GestureDetector(
              onTap: () {
                onTapMovie();
              },
              child: Text(
                movie?.title ?? "",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        SubText(
          movie?.releaseDate ?? "",
          textSize: TEXT_SMALL,
        ),
      ],
    );
  }
}