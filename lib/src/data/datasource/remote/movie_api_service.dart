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

class MovieApiService {
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
        return ResponseModel.fromJson(
          json.decode(response.body),
        ).results;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (e) {
      rethrow;
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
        return GenreModel.validGenres = GenreModel.fromJson(
          genreList,
        );
      } else {
        throw Exception('Failed to get genre data');
      }
    } catch (e) {
      rethrow;
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
        return ResponseModel.fromJson(
          json.decode(response.body),
        ).results;
      } else {
        throw Exception('Failed to fetch movies by genre');
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}
