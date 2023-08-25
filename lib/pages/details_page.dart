import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';
import '../../../custom_widgets.dart';
import '../../../models/movie.dart';
import '../models/genre_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  BoxDecoration buildBackdropDecoration(
    Alignment begin,
    Alignment end,
  ) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: UIConstants.backdropGradientColors,
        begin: begin,
        end: end,
        stops: UIConstants.backdropGradientStops,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIConstants.detailsBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: UIConstants.backdropAspectRatio,
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
