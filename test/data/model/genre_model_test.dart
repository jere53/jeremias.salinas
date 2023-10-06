import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/data/model/response_model.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';

void main() {
  group('create Movie from json', () {
    test('returns an item when data is valid', () {
      final validMovieJson = {
        'title': 'The Super Mario Bros. Movie',
        'original_title': 'The Super Mario Bros. Movie',
        'overview': 'While working underground to fix a water main, Brooklyn '
            'plumbers—and brothers—Mario and Luigi are transported down a mysterious '
            'pipe and wander into a magical new world. But when the brothers are separated, '
            'Mario embarks on an epic quest to find Luigi.',
        'release_date': '2023-04-05',
        'vote_average': 7.8,
        'genre_ids': [
          12,
          20,
        ],
        'backdrop_path': 'images/SuperMarioBackdrop.jpg',
        'poster_path': 'images/SuperMarioPoster.jpg',
        'adult': false,
        'original_language': 'en',
        'id': 0,
        'popularity': 100,
        'video': false,
        'vote_count': 100000,
      };

      final validItemJson = {
        'page': 12,
        'total_results': 19,
        'total_pages': 2,
        'results': [validMovieJson],
      };

      expect(
        ResponseModel.fromJson(validItemJson),
        isA<ResponseModel>()
            .having(
              (p0) => p0.page,
              'page parsed correctly',
              equals(
                validItemJson['page'],
              ),
            )
            .having(
              (p0) => p0.totalResults,
              'total results parsed correctly',
              equals(
                validItemJson['total_results'],
              ),
            )
            .having(
              (p0) => p0.totalPages,
              'total pages parsed correctly',
              equals(
                validItemJson['total_pages'],
              ),
            )
            .having(
              (p0) => p0.results.first,
              'movies parsed correctly',
              isA<Movie>(),
            ),
      );
    });

    test('returns an item with an empty/0 field when data is invalid', () {
      final invalidJson = {
        'page': 24,
      };

      expect(
        ResponseModel.fromJson(invalidJson),
        isA<ResponseModel>()
            .having(
              (p0) => p0.page,
              'valid page is parsed correctly',
              equals(
                invalidJson['page'],
              ),
            )
            .having(
              (p0) => p0.totalPages,
              'invalid total is replaced by a place holder',
              equals(0),
            ),
      );
    });
  });
}
