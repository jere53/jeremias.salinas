import 'dart:convert';

import 'package:flutter/services.dart';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_movie_repository.dart';
import '../model/genre_model.dart';

class MovieRepository implements IMovieRepository {
  List<Movie>? movies;

  static const String genresJsonPath = 'mock_data/genres.json';
  static const String moviesJsonPath = 'mock_data/movies.json';

  @override
  Future<DataState<List<Movie>>> getMovies([
    int page = 1,
    MovieEndpoint _ = MovieEndpoint.popular,
  ]) async {
    if (movies == null) {
      try {
        await _loadMoviesFromJson();
      } catch (e) {
        return DataFailed(Exception('failed to fetch movies'));
      }
    }

    return DataSuccess(movies ?? []);
  }

  Future<List<Movie>?> _loadMoviesFromJson() async {
    final String movieData = await rootBundle.loadString(moviesJsonPath);

    final List<Map<String, dynamic>> movieList =
        List.from(jsonDecode(movieData));

    return movies = movieList
        .map(
          (e) => Movie.fromJson(e),
        )
        .toList();
  }

  Future<void> _loadGenresFromJson() async {
    final String genreData = await rootBundle.loadString(genresJsonPath);
    final Map<String, dynamic> decodedGenreData = jsonDecode(genreData);

    final List<Map<String, dynamic>> genreList =
        List.from(decodedGenreData['genres']);

    final List<Genre> genres = GenreModel.fromJson(
      genreList,
    ).toList();

    GenreModel.validGenres = genres;
  }

  @override
  Future<DataState<List<Movie>>> getMoviesByGenre(
    int genre, [
    int page = 1,
  ]) async {
    final dataState = await getMovies(page);
    if (dataState is DataSuccess) {
      return DataSuccess(
        dataState.data!
            .where(
              (movie) => movie.genres.contains(
                GenreModel.validGenres
                    .firstWhere(
                      (validGenre) => validGenre.id == genre,
                    )
                    .id,
              ),
            )
            .toList(),
      );
    } else {
      return DataFailed(
        Exception('failed to fetch movies by genre'),
      );
    }
  }

  @override
  Future<DataState<List<Genre>>> getValidGenres() async {
    try {
      await _loadGenresFromJson();
      return DataSuccess(
        GenreModel.validGenres,
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
