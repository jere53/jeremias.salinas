import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';

void main() {
  group('create Movie from json', () {
    test('returns a movie when data is valid', () {
      final validJson = {
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

      expect(
        Movie.fromJson(validJson),
        isA<Movie>().having(
          (p0) => p0.originalLanguage,
          'data parsed correctly',
          equals('en'),
        ),
      );
    });

    test('returns a movie with an empty/0 field when data is null', () {
      final invalidJson = {
        'id': 24,
      };

      expect(
        Movie.fromJson(invalidJson),
        isA<Movie>()
            .having((p0) => p0.id, 'valid ID is parsed correctly', equals(24))
            .having(
              (p0) => p0.title,
              'invalid data is replaced by a place holder',
              equals(''),
            ),
      );
    });
  });
}
