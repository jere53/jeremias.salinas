import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/parameter/movie_parameter.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/repository/i_movie_repository.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_by_genre_usecase.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  group('fetchMoviesByGenre', () {
    final paramsValid = MovieApiParams(page: 1, genre: 12);
    final paramsInvalid = MovieApiParams(page: 1, genre: -100);

    test(
        'returns a list of Movies of a certain genre if the API call completes successfully',
        () async {
      final repository = MockMovieRepository();

      when(() => repository.getMoviesByGenre(paramsValid.genre!))
          .thenAnswer((_) async => DataSuccess([Movie.fromStatic()]));

      when(() => repository.getMoviesByGenre(paramsInvalid.genre!))
          .thenAnswer((_) async => DataFailed(Exception('error')));

      expect(
        await MoviesByGenreUsecase(repository: repository).call(paramsValid),
        isA<DataSuccess>()
            .having((result) => result.data, 'list is not empty', isNotEmpty),
      );

      expect(
        await MoviesByGenreUsecase(repository: repository).call(paramsInvalid),
        isA<DataFailed>()
            .having((result) => result.data, 'list is null', isNull),
      );
    });

    test('returns data failed if the api call completes with an error', () {
      final repository = MockMovieRepository();

      when(() => repository.getMoviesByGenre(paramsValid.genre!))
          .thenAnswer((_) async => DataFailed(Exception('error')));

      final params = MovieApiParams(page: 1, genre: paramsValid.genre);
      expect(
        MoviesByGenreUsecase(repository: repository).call(params),
        isA<Future<DataFailed>>(),
      );
    });
  });
}
