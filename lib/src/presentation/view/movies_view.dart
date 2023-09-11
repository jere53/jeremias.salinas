import 'package:flutter/material.dart';
import '../../../src/domain/repository/i_movie_repository.dart';

import '../../core/util/ui_constants.dart';
import '../../data/model/genre_model.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../widget/movie_poster.dart';
import '../widget/movie_score.dart';
import 'details_view.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({
    super.key,
    required this.repository,
  });

  final IMovieRepository repository;

  static const double borderRadius = 4;
  static const double rowPadding = 15;
  static const double posterHeight = 150 * 1.3;
  static const double posterWidth = 100 * 1.3;
  static const double imageSpacing = 20;
  static const double textSpacing = 5;
  static const double titleFontSize = 20;
  static const double scoreIconScale = 0.7;
  static const int displayedGenresAmount = 3;
  static const double genreCardPadding = 2;
  static const Text noDataText = Text('No data');

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  late Future<List<Movie>?> movies;

  @override
  void initState() {
    super.initState();
    movies = widget.repository.getMovies();
  }
  Card _buildMovieCard(Movie movie) {
    final String releaseYear = DateTime.parse(movie.releaseDate).year.toString();

    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MoviesView.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(MoviesView.rowPadding),
            child: Row(
              children: <Widget>[
                MoviePoster(
                  pathToPosterImg: movie.pathToPosterImg,
                  width: MoviesView.posterWidth,
                  height: MoviesView.posterHeight,
                ),
                Container(width: MoviesView.imageSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: MoviesView.textSpacing),
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Container(height: MoviesView.textSpacing),
                      Text(
                        releaseYear,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Container(height: MoviesView.textSpacing),
                      Wrap(
                        children: _buildGenresList(genres: movie.genres),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: MoviesView.scoreIconScale,
                          child: MovieScore(
                            movieScore: movie.score,
                            voteCount: movie.voteCount,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGenresList({required List<int> genres}) {
    final children = <Widget>[];
    final transformedGenres = <Genre>[];
    transformedGenres.addAll(
      GenreModel.validGenres.where(
            (g) => genres.contains(
          g.id,
        ),
      ),
    );
    for (final Genre genre in transformedGenres) {
      children.add(_buildGenreCard(genre));
    }
    return children;
  }

  Card _buildGenreCard(Genre genre) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(UIConstants.genreCardBorderRadius),
          ),
          border: Border.all(
            width: UIConstants.genreCardBorderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(MoviesView.genreCardPadding),
          child: Text(
            genre.name,
            style: const TextStyle(
              color: UIConstants.genreCardTextColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>?>(
      future: movies,
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Movie>?> snapshot,
          ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          final List<Movie> movies = snapshot.data!;
          movies.add(Movie.fromStatic());

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: ListView(
                children: [
                  for (Movie movie in movies)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsView(
                              movie: movie,
                            ),
                          ),
                        );
                      },
                      child: _buildMovieCard(movie),
                    ),
                ],
              ),
            ),
          );
        }
        return MoviesView.noDataText;
      },
    );
  }
}
