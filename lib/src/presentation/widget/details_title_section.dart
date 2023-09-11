import 'package:flutter/material.dart';
import 'package:movie_app_jsalinas/src/presentation/widget/release_date_text.dart';

import 'movie_title_text.dart';

class DetailsTitleSection extends StatelessWidget {
  const DetailsTitleSection({
    super.key,
    required this.movieTitle,
    required this.movieReleaseDate,
    required this.decoration,
  });

  final BoxDecoration decoration;
  final String movieTitle;
  final String movieReleaseDate;
  static const double height = 100;
  static const double titleTextAreaPadding = 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        foregroundDecoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(titleTextAreaPadding),
          child: Column(
            children: [
              MovieTitleText(
                movieTitle: movieTitle,
              ),
              Align(
                alignment: Alignment.topRight,
                child: ReleaseDateText(
                  releaseDate: movieReleaseDate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
