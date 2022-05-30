import 'package:flutter/material.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimension.dart';
import '../widgets/title_text.dart';
import 'horizontal_movie_list_view.dart';

class ComingSoonSectionView extends StatelessWidget {
  final String title;
  final List<MovieVO>? movieList;
  final Function onTapMovie;
  ComingSoonSectionView(
      this.title, {
        required this.movieList,
        required this.onTapMovie,
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: TitleText(title)),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          movieList: movieList,
          onTapMovie: (movieId) => onTapMovie(movieId),
        ),
      ],
    );
  }
}