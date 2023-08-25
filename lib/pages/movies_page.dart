import 'package:flutter/material.dart';
import 'package:movie_app_jsalinas/models/genre_model.dart';
import '../../../pages/details_page.dart';
import '../../../utils/i_movie_repository.dart';
import '../../../widgets/movie_poster.dart';
import '../../../widgets/movie_score.dart';
import '../../../utils/ui_constants.dart';
import '../../../models/movie.dart';
import '../models/genre.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({
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
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>?> movies;

  @override
  void initState() {
    super.initState();
    movies = widget.repository.getMovies();
  }
  Card _buildMovieCard(Movie movie) {
    String releaseYear = DateTime.parse(movie.releaseDate).year.toString();

    return Card(
      color: Colors.blueGrey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MoviesPage.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(MoviesPage.rowPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MoviePoster(
                  pathToPosterImg: movie.pathToPosterImg,
                  width: MoviesPage.posterWidth,
                  height: MoviesPage.posterHeight,
                ),
                Container(width: MoviesPage.imageSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: MoviesPage.textSpacing),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: MoviesPage.titleFontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: MoviesPage.textSpacing),
                      Text(
                        releaseYear,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Container(height: MoviesPage.textSpacing),
                      Wrap(
                        children: _buildGenresList(genreIDs: movie.genres),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: MoviesPage.scoreIconScale,
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

  List<Widget> _buildGenresList({required List<int> genreIDs}) {
    return GenreModel.validGenres
        .where(
          (validGenre) => genreIDs.contains(
        validGenre.id,
      ),
    )
        .map(
          (genre) => _buildGenreCard(genre),
    )
        .toList();
  }

  Card _buildGenreCard(Genre genre) {
    return Card(
      color: UIConstants.genreCardColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(UIConstants.genreCardBorderRadius),
          ),
          border: Border.all(
            color: UIConstants.genreCardBorderColor,
            width: UIConstants.genreCardBorderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(MoviesPage.genreCardPadding),
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
          List<Movie> movies = snapshot.data!;
          movies.add(Movie.fromStatic());

          return Scaffold(
            backgroundColor: UIConstants.detailsBackgroundColor,
            body: SafeArea(
              child: ListView(
                children: [
                  for (Movie movie in movies)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
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
        return MoviesPage.noDataText;
      },
    );
  }
}
