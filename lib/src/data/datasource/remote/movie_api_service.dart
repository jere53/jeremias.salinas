import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;

import '../../../core/util/constants.dart' as constants;
import '../../../core/util/enums.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import '../../model/genre_model.dart';
import '../../model/response_model.dart';
import '../local/DAOs/genre_dao.dart';
import '../local/DAOs/movie_dao.dart';

class MovieApiService {
  final MovieDao movieDao;
  final GenreDao genreDao;

  MovieApiService({required this.movieDao, required this.genreDao});

  Future<List<Movie>> fetchMovies(
    int page,
    MovieEndpoint endpoint,
  ) async {
    final Client client = Client();
    final String url = '${constants.baseMovieUrl}${endpoint.url}';

    try {
      final response = await client.get(
        Uri.parse(
          '$url?page=$page&api_key=${constants.apiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        final res = ResponseModel.fromJson(
          json.decode(response.body),
          page,
          endpoint,
        ).results;
        for (final movie in res) {
          movieDao.insertMovie(movie);
        }
      }

      return movieDao.fetchMovies(endpoint);
    } catch (e) {
      return movieDao.fetchMovies(endpoint);
    } finally {
      client.close();
    }
  }

  Future<List<Genre>> fetchGenres() async {
    final Client client = Client();
    try {
      final response = await client.get(
        Uri.parse(
          '${constants.baseGenreUrl}?language=en&api_key=${constants.apiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        final List<Map<String, dynamic>> genreList = List.from(
          json.decode(response.body)['genres'],
        );

        GenreModel.validGenres = GenreModel.fromJson(
          genreList,
        );

        for(final genre in GenreModel.validGenres){
          genreDao.insertGenre(genre);
        }
      }
      return genreDao.fetchGenres();
    } catch (e) {
      return genreDao.fetchGenres();
    } finally {
      client.close();
    }
  }

  Future<List<Movie>> fetchMoviesByGenre(
    int genre,
    int page,
  ) async {
    final Client client = Client();
    final String url =
        '${constants.discoverMovieUrl}?with_genres=$genre&page=$page';

    try {
      final response = await client.get(
        Uri.parse(
          '$url&api_key=${constants.apiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        final res = ResponseModel.fromJson(
          json.decode(response.body),
        ).results;

        for(final movie in res){
          movieDao.insertMovie(movie);
        }
      }

      return movieDao.fetchMoviesByGenre(
        '$genre',
      );
    } catch (e) {
      return movieDao.fetchMoviesByGenre(
        '$genre',
      );
    } finally {
      client.close();
    }
  }
}
