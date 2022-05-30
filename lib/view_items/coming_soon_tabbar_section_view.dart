import 'package:flutter/material.dart';

import '../data/vos/movie_vo.dart';
import 'movie_view.dart';
class ComingSoonTabBarSectionView extends StatelessWidget {
  final String title;
  final List<MovieVO>? movieList;
  final Function onTapMovie;
  ComingSoonTabBarSectionView(
      this.title, {
        required this.movieList,
        required this.onTapMovie,
      });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
      ),
      itemCount: movieList?.length ?? 0,
      itemBuilder: (BuildContext ctx, index) {
        return MovieView(
          movie: movieList?[index],
          onTapMovie: () {
            onTapMovie(movieList?[index].id);
          },
        );
      },
    );
  }
}
