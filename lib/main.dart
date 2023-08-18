import 'package:flutter/material.dart';
import '../../../utils/ui_constants.dart';
import 'custom_widgets.dart';
import '../../../models/movie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    Movie movie = Movie.fromStatic();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: UIConstants.detailsBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: UIConstants.backdropAspectRatio,
                child: DetailsBackdropSection(
                  pathToBackdropImg: movie.pathToBackdropImg,
                  genres: movie.genres,
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
              ),
              MovieOverviewText(
                movieOverviewTxt: movie.overview,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
