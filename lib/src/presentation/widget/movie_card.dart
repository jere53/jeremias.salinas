import 'package:flutter/material.dart';

import '../../data/model/genre_model.dart';
import '../../domain/entity/movie.dart';
import 'genre_card.dart';
import 'movie_poster.dart';
import 'movie_score.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  static const double borderRadius = 4;
  static const double columnPadding = 15;
  static const double posterHeight = 150 * 1.3;
  static const double posterWidth = 100 * 1.3;
  static const double imageSpacing = 20;
  static const double textSpacing = 5;
  static const double titleFontSize = 20;
  static const int displayedGenresAmount = 3;
  static const int maxTitleLines = 2;
  static const double scoreIconScale = 0.5;

  @visibleForTesting
  String get releaseYear {
    try {
      return DateTime.parse(movie.releaseDate).year.toString();
    } on FormatException {
      return '0000';
    }
  }

  @visibleForTesting
  List<String> getGenreNames() => GenreModel.validGenres
      .where(
        (g) => movie.genres.contains(
          g.id,
        ),
      )
      .map(
        (e) => e.name,
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(columnPadding),
            child: Column(
              children: <Widget>[
                MoviePoster(
                  pathToPosterImg: movie.pathToPosterImg,
                  width: posterWidth,
                  height: posterHeight,
                ),
                Container(height: imageSpacing),
                Column(
                  children: <Widget>[
                    Text(
                      movie.title,
                      maxLines: maxTitleLines,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: titleFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: textSpacing),
                    Text(
                      releaseYear,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Container(height: textSpacing),
                    Wrap(
                      children: [
                        for (String genre
                            in getGenreNames().take(displayedGenresAmount))
                          GenreCard(item: genre),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.scale(
            alignment: Alignment.topLeft,
            scale: scoreIconScale,
            child: MovieScore(
              movieScore: movie.score,
              voteCount: movie.voteCount,
            ),
          ),
        ],
      ),
    );
  }
}
