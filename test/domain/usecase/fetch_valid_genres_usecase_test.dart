import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/repository/i_movie_repository.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/valid_genres_usecase.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  group('fetch valid genres', () {
    test(
        'returns a list of Movies of a certain genre if the API call completes successfully',
        () async {
      final repository = MockMovieRepository();

      when(() => repository.getValidGenres()).thenAnswer(
        (_) async => DataSuccess(
          List.generate(
            10,
            (index) => Genre(
              index,
              '$index',
            ),
          ),
        ),
      );
      expect(
        await ValidGenresUseCase(repository: repository).call(),
        isA<DataSuccess>()
            .having((result) => result.data, 'list is not empty', isNotEmpty),
      );
    });

    test('returns data failed if the api call completes with an error', () {
      final repository = MockMovieRepository();

      when(() => repository.getValidGenres())
          .thenAnswer((_) async => DataFailed(Exception('error')));

      expect(
        ValidGenresUseCase(repository: repository).call(),
        isA<Future<DataFailed>>(),
      );
    });
  });
}
