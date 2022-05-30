import 'package:flutter/material.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimension.dart';
import 'movie_view.dart';

class HorizontalMovieListView extends StatelessWidget {
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;
  HorizontalMovieListView({
    required this.movieList,
    required this.onTapMovie,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      height: HORIZONTAL_LISTVIEW_HEIGHT,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: MARGIN_MEDIUM,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movieList?.length,
        itemBuilder: (context, index) {
          return MovieView(
            movie: movieList?[index],
            onTapMovie: () {
              onTapMovie(movieList?[index].id);
            },
          );
        },
      ),
    );
  }
}
