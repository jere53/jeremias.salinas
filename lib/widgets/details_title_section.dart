import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';
import '../../../widgets/movie_title_text.dart';
import '../../../widgets/release_date_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        foregroundDecoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.titleTextAreaPadding),
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
