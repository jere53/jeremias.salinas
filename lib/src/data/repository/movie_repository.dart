import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_movie_repository.dart';
import '../model/genre_model.dart';

class MovieRepository implements IMovieRepository {
  List<Movie>? movies;

  static const String genresJsonPath = 'mock_data/genres.json';
  static const String moviesJsonPath = 'mock_data/movies.json';

  @override
  Future<List<Movie>?> getMovies() async {
    if (movies == null) {
      await _loadMoviesFromJson();
    }
    return movies;
  }

  Future<List<Movie>?> _loadMoviesFromJson() async {
    final String genreData = await rootBundle.loadString(genresJsonPath);
    final String movieData = await rootBundle.loadString(moviesJsonPath);

    final Map<String, dynamic> decodedGenreData =
        jsonDecode(genreData);

    final List<Map<String, dynamic>> genreList =
        List.from(decodedGenreData['genres']);

    final List<Genre> genres = GenreModel.fromJson(
      genreList,
    ).toList();

    GenreModel.validGenres = genres;

    final List<Map<String, dynamic>> movieList =
        List.from(jsonDecode(movieData));

    return movies = movieList.map((e) => Movie.fromJson(e)).toList();
  }
}
