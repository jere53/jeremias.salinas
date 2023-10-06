import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';

void main() {
  group('create Movie from json', () {
    test('returns a genre when data is valid', () {
      final validJson = {
        'id': 12,
        'name': 'Action',
      };

      expect(
        Genre.fromJson(validJson),
        isA<Genre>()
            .having((p0) => p0.name, 'name parsed correctly', equals('Action'))
            .having((p0) => p0.id, 'id parsed correctly', equals(12)),
      );
    });

    test('returns a genre with an empty/0 field when data is null', () {
      final invalidJson = {
        'id': 24,
      };

      expect(
        Genre.fromJson(invalidJson),
        isA<Genre>()
            .having((p0) => p0.id, 'valid ID is parsed correctly', equals(24))
            .having(
              (p0) => p0.name,
              'invalid name is replaced by a place holder',
              equals(''),
            ),
      );
    });
  });
}
