import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../models/genre_model.dart';
import '../../../models/genre.dart';
import '../../../models/movie.dart';
import '../../../utils/i_movie_repository.dart';

class MovieRepository implements IMovieRepository {
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
    String genreData = await rootBundle.loadString(genresJsonPath);
    String movieData = await rootBundle.loadString(moviesJsonPath);

    List<Genre>? genres =
        GenreModel.fromJson(jsonDecode(genreData)['genres'] as List)?.toList();

    if (genres != null) {
      GenreModel.validGenres = genres;
    }

    movies = (jsonDecode(movieData) as List)
        .map((e) => Movie.fromJson(e))
        .toList();

    return movies;
  }

  List<Movie>? movies;
}
