import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_jsalinas/src/core/util/data_state.dart';
import 'package:movie_app_jsalinas/src/domain/entity/genre.dart';
import 'package:movie_app_jsalinas/src/domain/entity/movie.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/movies_by_genre_usecase.dart';
import 'package:movie_app_jsalinas/src/domain/usecase/implementation/valid_genres_usecase.dart';
import 'package:movie_app_jsalinas/src/presentation/bloc/movie_with_genre_bloc.dart';

class MockMoviesByGenreUseCase extends Mock implements MoviesByGenreUsecase {}

class MockGenresUseCase extends Mock implements ValidGenresUseCase {}

void main() {
  group('calling bloc fetch methods', () {
    final moviesByGenreUseCase = MockMoviesByGenreUseCase();
    final genresUseCase = MockGenresUseCase();
    final MovieWithGenreBloc bloc = MovieWithGenreBloc(
      moviesByGenreUsecase: moviesByGenreUseCase,
      validGenresUseCase: genresUseCase,
    );

    test('calling fetch movies by genre populates the stream properly',
        () async* {
      final results = List.generate(
        20,
        (index) => Movie.fromStatic(),
      );

      when(() => moviesByGenreUseCase.call(any())).thenAnswer(
        (_) async => DataSuccess(
          results,
        ),
      );
      final expected = [results, results, emitsDone];
      bloc.fetchMoviesByGenre(1);
      bloc.fetchMoviesByGenre(1);
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
      when(() => moviesByGenreUseCase.call(any())).thenAnswer(
        (_) async => DataFailed(
          Exception(),
        ),
      );

      final expected = [emitsError(isA<Exception>()), emitsDone];
      bloc.fetchMoviesByGenre(1);
      expect(bloc.moviesStream, emitsInOrder(expected));
    });
  });
}
