import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/core/util/enums.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_from_endpoint_usecase.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/valid_genres_usecase.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_from_endpoint_bloc.dart';

class MockMoviesUseCase extends Mock implements PopularUseCase {}

class MockGenresUseCase extends Mock implements ValidGenresUseCase {}

void main() {
  group('calling bloc fetch methods', () {
    final moviesUseCase = MockMoviesUseCase();
    final genresUseCase = MockGenresUseCase();

    final MoviesFromEndpointBloc bloc = MoviesFromEndpointBloc(
      moviesUseCase: moviesUseCase,
      validGenresUseCase: genresUseCase,
    );

    setUp(() => registerFallbackValue(MovieEndpoint.popular));
    test('calling fetch movies populates the stream properly', () async* {
      final results = List.generate(
        20,
        (index) => Movie.fromStatic(),
      );

      when(() => moviesUseCase.call(any())).thenAnswer(
        (_) async => DataSuccess(
          results,
        ),
      );
      final expected = [results, results, emitsDone];
      bloc.fetchMovies();
      bloc.fetchMovies();
      expect(bloc.moviesStream, emitsInOrder(expected));
    });
    test('calling fetch valid genres returns list of genres', () async {
      when(() => genresUseCase.call()).thenAnswer(
        (_) async => const DataSuccess(
          [],
        ),
      );

      expect(bloc.fetchValidGenres(), isA<Future<DataSuccess<List<Genre>>>>());
    });

    test('calling fetch valid genres returns a data error when repo call fails',
        () async {
      when(() => genresUseCase.call()).thenAnswer(
        (_) async => DataFailed(
          Exception(),
        ),
      );

      expect(bloc.fetchValidGenres(), isA<Future<DataFailed>>());
    });

    test('calling fetch movies emits error when repo call fails', () async* {
      when(() => moviesUseCase.call(any())).thenAnswer(
        (_) async => DataFailed(
          Exception(),
        ),
      );

      final expected = [emitsError(isA<Exception>()), emitsDone];
      bloc.fetchMovies();
      expect(bloc.moviesStream, emitsInOrder(expected));
    });
  });
}
