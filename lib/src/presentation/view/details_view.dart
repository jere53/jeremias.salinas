import 'package:flutter/material.dart';

import '../../data/model/genre_model.dart';
import '../../domain/entity/movie.dart';
import '../widget/details_backdrop_section.dart';
import '../widget/details_poster_section.dart';
import '../widget/details_title_section.dart';
import '../widget/movie_overview_text.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    super.key,
    required this.movie,
  });

  static const double backdropAspectRatio = 16 / 9;
  static const List<double> backdropGradientStops = [
    0,
    0.1,
  ];
  static const List<Color> backdropGradientColors = [
    Colors.black54,
    Colors.transparent,
  ];

  final Movie movie;

  BoxDecoration buildBackdropDecoration(
    Alignment begin,
    Alignment end,
  ) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: backdropGradientColors,
        begin: begin,
        end: end,
        stops: backdropGradientStops,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: backdropAspectRatio,
              child: DetailsBackdropSection(
                pathToBackdropImg: movie.pathToBackdropImg,
                genres: GenreModel.validGenres
                    .where(
                      (g) => movie.genres.contains(
                        g.id,
                      ),
                    )
                    .map(
                      (e) => e.name,
                    )
                    .toList(),
                decoration: buildBackdropDecoration(
                  Alignment.bottomCenter,
                  Alignment.topCenter,
                ),
              ),
            ),
            DetailsTitleSection(
              movieTitle: movie.title,
              movieReleaseDate: movie.releaseDate,
              decoration: buildBackdropDecoration(
                Alignment.topCenter,
                Alignment.bottomCenter,
              ),
            ),
            DetailsPosterSection(
              pathToPosterImg: movie.pathToPosterImg,
              movieScore: movie.score,
              voteCount: movie.voteCount,
            ),
            MovieOverviewText(
              movieOverviewTxt: movie.overview,
            ),
          ],
        ),
      ),
    );
  }
}
